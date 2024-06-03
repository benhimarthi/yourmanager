import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/features/notifications/domain/entities/notification.dart';

class StockNotification extends Notifications {
  const StockNotification({
    required super.id,
    required super.title,
    required super.message,
    required super.link,
    required super.time,
    required super.viewed,
  });

  factory StockNotification.fromFirebaseFireStore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return StockNotification(
      id: doc.id,
      title: data['title'] ?? '',
      message: data['message'] ?? '',
      link: data['link'] ?? '',
      time: data['time'] ?? '',
      viewed: data['viewed'],
    );
  }
}
