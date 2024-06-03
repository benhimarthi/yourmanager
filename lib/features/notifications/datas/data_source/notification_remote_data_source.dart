import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/features/notifications/datas/models/stock_notification.dart';

import '../../domain/entities/notification.dart';

abstract class NotificationRemoteDataSource {
  Future<Notifications> createNotification(
    String title,
    String message,
    String link,
    DateTime time,
    bool view,
  );
  Future<Notifications> getNotification(String id);
  Future<List<Notifications>> getAllNotifications();
  Future<void> deleteNotification(String id);
  Future<void> updateNotification(String id, bool view);
}

class StockNotificationsRemoteDataSource extends NotificationRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;

  StockNotificationsRemoteDataSource(this._firebaseFirestore);

  @override
  Future<StockNotification> createNotification(String title, String message,
      String link, DateTime time, bool view) async {
    try {
      CollectionReference ref =
          _firebaseFirestore.collection('stock_notifications');
      DocumentReference saveNotif = await ref.add({
        'title': title,
        'message': message,
        'link': link,
        'viewed': view,
        'time': time.toString()
      });
      final result = await ref.doc(saveNotif.id).get();
      return StockNotification.fromFirebaseFireStore(result);
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
        message: e.message.toString(),
        statusCode: int.parse(e.code),
      );
    }
  }

  @override
  Future<void> deleteNotification(String id) async {
    try {
      await _firebaseFirestore
          .collection('stock_notifications')
          .doc(id)
          .delete();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
        message: e.message.toString(),
        statusCode: int.parse(e.code),
      );
    }
  }

  @override
  Future<List<StockNotification>> getAllNotifications() async {
    try {
      List<StockNotification> results = [];
      final notifs =
          await _firebaseFirestore.collection('stock_notifications').get();
      for (var n in notifs.docs) {
        results.add(StockNotification.fromFirebaseFireStore(n));
      }
      return results;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
        message: e.message.toString(),
        statusCode: int.parse(e.code),
      );
    }
  }

  @override
  Future<StockNotification> getNotification(String id) async {
    try {
      final notif = await _firebaseFirestore
          .collection('stock_notifications')
          .doc(id)
          .get();
      return StockNotification.fromFirebaseFireStore(notif);
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
        message: e.message.toString(),
        statusCode: int.parse(e.code),
      );
    }
  }

  @override
  Future<void> updateNotification(String id, bool view) async {
    try {
      await _firebaseFirestore
          .collection('stock_notifications')
          .doc(id)
          .update({'viewed': view});
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
        message: e.message.toString(),
        statusCode: int.parse(e.code),
      );
    }
  }
}
