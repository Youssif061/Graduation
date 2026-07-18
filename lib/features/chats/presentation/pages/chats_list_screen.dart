import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/chats/data/chat_repository.dart';
import 'package:expertisemarket/features/chats/presentation/pages/chat_detail_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  String get _currentUserId => FirebaseAuth.instance.currentUser?.uid ?? 'guest';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text("Please sign in to view chats"),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.marketBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "My Messages",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.navyColor,
          ),
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: ChatRepository.instance.getChatRooms(_currentUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error loading messages: ${snapshot.error}"),
            );
          }

          final chatRooms = snapshot.data ?? [];
          if (chatRooms.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "No active conversations.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: chatRooms.length,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
              indent: 72,
              endIndent: 16,
              color: AppColors.marketBorder,
            ),
            itemBuilder: (context, index) {
              final room = chatRooms[index];
              final roomId = room['roomId'] as String;
              final users = List<String>.from(room['users'] ?? []);
              final recipientId = users.firstWhere(
                (uid) => uid != _currentUserId,
                orElse: () => '',
              );

              final names = Map<String, dynamic>.from(room['names'] ?? {});
              final recipientName = names[recipientId]?.toString() ?? 'Expert';
              final senderName = names[_currentUserId]?.toString() ?? 'Client';

              final lastMsg = room['lastMessage'] as String? ?? '';
              final timeStamp = room['lastMessageTime'] as Timestamp?;
              String timeStr = '';
              if (timeStamp != null) {
                final date = timeStamp.toDate();
                timeStr = "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
              }

              return ListTile(
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                  child: Text(
                    recipientName.isNotEmpty ? recipientName[0].toUpperCase() : 'C',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.navyColor,
                    ),
                  ),
                ),
                title: Text(
                  recipientName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.navyColor,
                  ),
                ),
                subtitle: Text(
                  lastMsg,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                trailing: Text(
                  timeStr,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMutedColor,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatDetailPage(
                        roomId: roomId,
                        recipientId: recipientId,
                        recipientName: recipientName,
                        senderName: senderName,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
