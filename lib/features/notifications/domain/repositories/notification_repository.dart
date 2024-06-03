import 'package:yourmanager/core/util/typedef.dart';

import '../entities/notification.dart';

abstract class NotificationRepository {
  ResultFuture<Notifications> createNotification(
    String title,
    String message,
    String link,
    bool viewed,
    DateTime time,
  );
  ResultFuture<Notifications> getNotification(String id);
  ResultFuture<List<Notifications>> getAllNotifications();
  ResultVoid deleteNotification(String id);
  ResultVoid updateNotification(String id, bool view);
}
