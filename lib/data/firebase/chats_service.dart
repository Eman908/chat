import 'package:chat/core/constants/app_constants.dart';
import 'package:chat/data/models/chat_and_users.dart';
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

  Future<void> addUserToFirestore(UserModel user) {
    return _getUserCollection().doc(user.uId).set(user);
  }

  Future<UserModel>? addUserByEmail(String email, String currentUserId) async {
    var data = await _getUserCollection()
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (data.docs.isEmpty) {
      throw Exception('There is no user with this email');
    }
    final otherUserId = data.docs.first.data().uId;
    bool isExisted = await isChatExistsBetween(
      currentUserId,
      otherUserId ?? '',
    );
    if (isExisted) {
      throw Exception('Already Added');
    }
    if (data.docs.first.data().uId == currentUserId) {
      throw Exception('This is the current user');
    }
    final getOtherUserId = data.docs.first.data().uId;
    await createChat(
      currentUserId: currentUserId,
      otherUserId: getOtherUserId ?? '',
    );
    return data.docs.first.data();
  }

  Future<void> createChat({
    required String currentUserId,
    required String otherUserId,
  }) async {
    try {
      final chatId = _buildChatId(currentUserId, otherUserId);

      final existingChat = await _getChatsCollection().doc(chatId).get();
      if (existingChat.exists) {
        throw Exception('Chat already exists');
      }

      final chat = ChatModel(
        chatId: chatId,
        lastMessage: 'No messages yet',
        participants: [currentUserId, otherUserId],
      );

      await _getChatsCollection().doc(chatId).set(chat);
    } catch (e) {
      rethrow;
    }
  }

  String _buildChatId(String uid1, String uid2) {
    return uid1.compareTo(uid2) < 0 ? '${uid1}_$uid2' : '${uid2}_$uid1';
  }

  Future<void> addChatToFirestore(ChatModel chat) async {
    return _getChatsCollection().doc(chat.chatId).set(chat);
  }

  Future<bool> isChatExistsBetween(
    String currentUserId,
    String otherUserId,
  ) async {
    String chatId = _buildChatId(currentUserId, otherUserId);
    var data = await _getChatsCollection().doc(chatId).get();
    if (data.exists) {
      return true;
    }
    return false;
  }

  Future<ChatAndUsers> getUserChatsAndData(String currentUserId) async {
    try {
      final chatsData = await _getChatsCollection()
          .where('participants', arrayContains: currentUserId)
          .get();

      final chats = <ChatModel>[];
      final users = <UserModel>[];

      for (final chatDoc in chatsData.docs) {
        if (!chatDoc.exists) continue;

        final chat = chatDoc.data();
        final participants = chat.participants ?? [];

        if (participants.isEmpty || !participants.contains(currentUserId)) {
          continue;
        }

        chats.add(chat);

        final otherUserId = participants.firstWhere(
          (id) => id != currentUserId,
          orElse: () => '',
        );

        if (otherUserId.isNotEmpty) {
          try {
            final userDoc = await _getUserCollection().doc(otherUserId).get();
            if (userDoc.exists) {
              final user = userDoc.data();
              if (user != null) {
                users.add(user);
              }
            }
          } catch (e) {}
        }
      }

      return ChatAndUsers(chats: chats, users: users);
    } catch (e) {
      return ChatAndUsers(chats: [], users: []);
    }
  }
}
