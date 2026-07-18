import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/chats/data/models/message_model.dart';
import 'package:expertisemarket/features/chats/data/chat_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatDetailPage extends StatefulWidget {
  final String roomId;
  final String recipientId;
  final String recipientName;
  final String senderName;

  const ChatDetailPage({
    super.key,
    required this.roomId,
    required this.recipientId,
    required this.recipientName,
    required this.senderName,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _imagePicker = ImagePicker();

  String get _currentUserId => FirebaseAuth.instance.currentUser?.uid ?? 'guest';

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage({String? imageUrl}) async {
    final text = _messageController.text.trim();
    if (text.isEmpty && imageUrl == null) return;

    _messageController.clear();

    try {
      await ChatRepository.instance.sendMessage(
        roomId: widget.roomId,
        senderId: _currentUserId,
        text: text,
        imageUrl: imageUrl,
        recipientId: widget.recipientId,
        recipientName: widget.recipientName,
        senderName: widget.senderName,
      );
      _scrollToBottom();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error sending message: $e")),
      );
    }
  }

  Future<void> _pickAndSendImage(ImageSource source) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: source, imageQuality: 70);
      if (pickedFile == null) return;

      // Show loader SNACKBAR
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Row(children: [CircularProgressIndicator(), SizedBox(width: 12), Text("Sending image...")]), duration: Duration(seconds: 4)),
      );

      final file = File(pickedFile.path);
      String? uploadUrl;

      try {
        final ref = FirebaseStorage.instance
            .ref()
            .child('chat_images')
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
        final uploadTask = await ref.putFile(file);
        uploadUrl = await uploadTask.ref.getDownloadURL();
      } catch (_) {
        // Fallback to local path for offline/unconfigured Storage preview
        uploadUrl = pickedFile.path;
      }

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      await _sendMessage(imageUrl: uploadUrl);
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send image: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.marketBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: Text(
                widget.recipientName.isNotEmpty ? widget.recipientName[0].toUpperCase() : 'P',
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navyColor),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipientName,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.navyColor),
                  ),
                  const Text(
                    "Online",
                    style: TextStyle(fontSize: 11, color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Messages Feed
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: ChatRepository.instance.getMessages(widget.roomId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error loading chats: ${snapshot.error}"));
                }

                final messages = snapshot.data ?? [];
                if (messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 12),
                        const Text(
                          "No messages yet.\nStart the conversation!",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }

                // Schedule scroll to bottom
                WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message.senderId == _currentUserId;
                    return _buildMessageBubble(message, isMe);
                  },
                );
              },
            ),
          ),

          // Input field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppColors.marketBorder)),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Attachment button
                  IconButton(
                    icon: const Icon(Icons.image, color: AppColors.primaryColor),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => SafeArea(
                          child: Wrap(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text("Camera"),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickAndSendImage(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text("Gallery"),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickAndSendImage(ImageSource.gallery);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // Text Box
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.marketInputBg,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _messageController,
                        maxLines: null,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: "Type a message...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Send button
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.navyColor,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 18),
                      onPressed: () => _sendMessage(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(MessageModel message, bool isMe) {
    final bubbleColor = isMe ? AppColors.navyColor : Colors.white;
    final textColor = isMe ? Colors.white : AppColors.marketText;
    final alignment = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleRadius = isMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: bubbleRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.imageUrl != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: message.imageUrl!.startsWith('assets/') || !message.imageUrl!.startsWith('http')
                        ? Image.file(
                            File(message.imageUrl!),
                            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100),
                          )
                        : Image.network(
                            message.imageUrl!,
                            loadingBuilder: (_, child, progress) {
                              if (progress == null) return child;
                              return const SizedBox(width: 100, height: 100, child: Center(child: CircularProgressIndicator()));
                            },
                            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100),
                          ),
                  ),
                  if (message.text.isNotEmpty) const SizedBox(height: 8),
                ],
                if (message.text.isNotEmpty)
                  Text(
                    message.text,
                    style: TextStyle(color: textColor, fontSize: 14),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "${message.createdAt.hour.toString().padLeft(2, '0')}:${message.createdAt.minute.toString().padLeft(2, '0')}",
            style: const TextStyle(fontSize: 10, color: AppColors.textMutedColor),
          ),
        ],
      ),
    );
  }
}
