// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';

import 'package:fit_flex_club/src/features/chat/data/models/chat_model.dart';
import 'package:fit_flex_club/src/features/chat/data/models/message_model.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/chat_entity.dart';
import 'package:fit_flex_club/src/features/chat/domain/entities/message_entity.dart';
import 'package:injectable/injectable.dart';

abstract class ChatRemoteDatasource {
  ///
  Future<Stream<List<ChatModel>>> watchChats();

  ///
  Future<Stream<ChatModel?>> getChat();

  ///
  Future<List<ChatModel>> getAllChats();

  ///
  Future<Stream<List<MessageModel>>> watchMessagesByChatId({
    required String chatId,
  });

  ///
  Future<void> startChat({required ChatModel chat});

  ///
  Future<void> sendMessage({
    required MessageModel message,
    required ChatModel chat,
  });

  ///
  Future<void> updateMessageStatus({
    required List<MessageModel> unReadMessages,
    required ChatModel chat,
  });
}

@Singleton(as: ChatRemoteDatasource)
class ChatRemoteDatasourceImpl extends ChatRemoteDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore remoteDb;
  ChatRemoteDatasourceImpl({
    required this.auth,
    required this.remoteDb,
  });
  @override
  Future<Stream<ChatModel?>> getChat() async {
    final authId = auth.currentUser?.uid;
    if (authId == null) {
      throw ServerException(errorMessage: "Auth ID not found");
    }

    // Optional: You can do some one-time await setup here if needed

    final stream = remoteDb
        .collection('chats')
        .where('memberIds', arrayContains: authId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;

      final doc = snapshot.docs.first;
      return ChatModel.fromMap(doc.id, doc.data());
    });

    return stream;
  }

  @override
  Future<void> sendMessage({
    required MessageModel message,
    required ChatModel chat,
  }) async {
    try {
      final authId = auth.currentUser?.uid;
      if (authId == null) {
        throw ServerException(errorMessage: "Auth ID not found");
      }
      final CollectionReference chatRef = remoteDb.collection('chats');
      await chatRef.doc(chat.id).set(
            chat.toMap(),
          );
      await chatRef
          .doc(chat.id)
          .collection('messages')
          .doc(message.id)
          .set(message.toMap());
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> startChat({required ChatModel chat}) async {
    try {
      final CollectionReference ref = remoteDb.collection('chats');
      await ref.doc(chat.id).set(chat.toMap(), SetOptions(merge: true));
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<Stream<List<ChatModel>>> watchChats() async {
    try {
      final authId = auth.currentUser?.uid;
      if (authId == null) {
        throw ServerException(
          errorMessage: "Auth ID not found",
        );
      }
      final chatStream = remoteDb
          .collection('chats')
          .where('memberIds', arrayContains: authId)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map(
                (doc) => ChatModel.fromMap(
                  doc.id,
                  doc.data(),
                ),
              )
              .toList());

      return chatStream;
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<Stream<List<MessageModel>>> watchMessagesByChatId({
    required String chatId,
  }) async {
    try {
      final messageStream = remoteDb
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: false) // Optional: sort messages
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((doc) => MessageModel.fromMap(doc.id, doc.data()))
              .toList());

      return messageStream;
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> updateMessageStatus({
    required List<MessageModel> unReadMessages,
    required ChatModel chat,
  }) async {
    try {
      final authId = auth.currentUser?.uid;
      // Update message status
      for (final unReadMessage in unReadMessages) {
        await remoteDb
            .collection('chats')
            .doc(chat.id)
            .collection('messages')
            .doc(unReadMessage.id)
            .update({
          'readBy': unReadMessage.readBy.map(
            (obj) => {
              'userId': obj,
              'timestamp': DateTime.now().millisecondsSinceEpoch
            },
          ),
        });
      }
      // Update chat status
      await remoteDb.collection('chats').doc(chat.id).update(
        {'unreadCount.$authId': 0},
      );
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<List<ChatModel>> getAllChats() async {
    try {
      final authId = auth.currentUser?.uid;
      if (authId == null) {
        throw ServerException(
          errorMessage: "Auth ID not found",
        );
      }
      final snapShot = await remoteDb
          .collection('chats')
          .where('memberIds', arrayContains: authId)
          .get();

      if (snapShot.docs.isEmpty) {
        return [];
      }

      return snapShot.docs.map((doc) {
        final data = doc.data();
        return ChatModel.fromMap(doc.id, data);
      }).toList();
    } on FirebaseException catch (err) {
      throw ServerException(
        errorMessage: err.message ?? "Something went wrong!",
        errorCode: err.code,
      );
    }
  }
}
