import 'package:chat/core/constants/app_constants.dart';
import 'package:chat/data/models/chat_model.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
class ChatsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<UserModel> _getUserCollection() {
    return _firestore
        .collection(AppConstants.kUsersCollection)
        .withConverter(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  CollectionReference<ChatModel> _getChatsCollection() {
    return _firestore
        .collection(AppConstants.kChatCollection)
        .withConverter(
          fromFirestore: (snapshot, _) => ChatModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  String _buildChatId(String uid1, String uid2) {
    return uid1.compareTo(uid2) < 0 ? '${uid1}_$uid2' : '${uid2}_$uid1';
  }

  Future<void> addUserToFirestore(UserModel user) {
    return _getUserCollection().doc(user.uId).set(user);
  }

  Future<void> addChatToFirestore(ChatModel chat) async {
    final chatDoc = _getChatsCollection().doc(chat.chatId);
    final exists = await chatDoc.get();
    if (!exists.exists) {
      await chatDoc.set(chat);
    }
  }

  Future<bool> isChatExistsBetween(
    String currentUserId,
    String otherUserId,
  ) async {
    final chatId = _buildChatId(currentUserId, otherUserId);
    final doc = await _getChatsCollection().doc(chatId).get();
    return doc.exists;
  }

  Future<List<UserModel>> getUsersFromChats({
    required String currentUserId,
  }) async {
    try {
      final chatsSnapshot = await _getChatsCollection()
          .where('participants', arrayContains: currentUserId)
          .get();

      final users = <UserModel>[];

      for (final chatDoc in chatsSnapshot.docs) {
        final participants = List<String>.from(chatDoc['participants'] ?? []);

        final otherUserId = participants.firstWhere(
          (id) => id != currentUserId,
          orElse: () => '',
        );

        if (otherUserId.isNotEmpty) {
          final userDoc = await _firestore
              .collection('users')
              .doc(otherUserId)
              .get();

          if (userDoc.exists) {
            final user = UserModel.fromJson(userDoc.data()!);
            users.add(user);
          }
        }
      }

      return users;
    } catch (e) {
      return [];
    }
  }

  Future<UserModel?> searchUserWithChatCheck({
    required String email,
    required String currentUserId,
  }) async {
    final querySnapshot = await _getUserCollection()
        .where('email', isEqualTo: email.trim().toLowerCase())
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) return null;

    final otherUser = querySnapshot.docs.first.data();

    if (otherUser.uId == currentUserId) {
      throw Exception('This is the current user');
    }

    final chatExists = await isChatExistsBetween(currentUserId, otherUser.uId!);
    if (chatExists) {
      throw Exception('Chat already exists with this user');
    }

    return otherUser;
  }

  Future<void> createChatIfNotExists({
    required String currentUserId,
    required String otherUserId,
  }) async {
    final chatId = _buildChatId(currentUserId, otherUserId);

    final chatDoc = _getChatsCollection().doc(chatId);
    final exists = await chatDoc.get();

    if (!exists.exists) {
      final chat = ChatModel(
        chatId: chatId,
        participants: [currentUserId, otherUserId],
        lastMessage: '',
      );
      await chatDoc.set(chat);
    }
  }
}
