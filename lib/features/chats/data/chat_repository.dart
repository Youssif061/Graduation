import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/message_model.dart';

class ChatRepository {
  ChatRepository._();
  static final ChatRepository instance = ChatRepository._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String getRoomId(String uid1, String uid2) {
    return uid1.compareTo(uid2) < 0 ? '${uid1}_$uid2' : '${uid2}_$uid1';
  }

  Future<void> sendMessage({
    required String roomId,
    required String senderId,
    required String text,
    String? imageUrl,
    required String recipientId,
    required String recipientName,
    required String senderName,
  }) async {
    final now = DateTime.now();

    // Create or update chat room header
    await _firestore.collection('chats').doc(roomId).set({
      'roomId': roomId,
      'lastMessage': text.isEmpty && imageUrl != null ? '📷 Image' : text,
      'lastMessageTime': Timestamp.fromDate(now),
      'users': [senderId, recipientId],
      'names': {
        senderId: senderName,
        recipientId: recipientName,
      },
    }, SetOptions(merge: true));

    // Save message document in messages subcollection
    await _firestore
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .add({
      'senderId': senderId,
      'text': text,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(now),
      'isRead': false,
    });
  }

  Stream<List<MessageModel>> getMessages(String roomId) {
    return _firestore
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Stream<List<Map<String, dynamic>>> getChatRooms(String userId) {
    return _firestore
        .collection('chats')
        .where('users', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
      final list = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      // Client-side sort to avoid Firestore composite index setup issues
      list.sort((a, b) {
        final t1 = a['lastMessageTime'] as Timestamp?;
        final t2 = b['lastMessageTime'] as Timestamp?;
        if (t1 == null || t2 == null) return 0;
        return t2.compareTo(t1); // Descending
      });

      return list;
    });
  }
}
