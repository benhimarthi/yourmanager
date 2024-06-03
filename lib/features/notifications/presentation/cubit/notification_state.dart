import 'package:equatable/equatable.dart';
import 'package:yourmanager/features/notifications/domain/entities/notification.dart';

class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

class NotificationCreatedSuccessfully extends NotificationState {
  final Notifications notifications;
  const NotificationCreatedSuccessfully(this.notifications);
}

class NotificationCreationFailed extends NotificationState {
  final String message;
  const NotificationCreationFailed(this.message);
}

class GetNotificationSuccessfully extends NotificationState {
  final Notifications notif;
  const GetNotificationSuccessfully(this.notif);
}

class GetNotificationFailed extends NotificationState {
  final String message;
  const GetNotificationFailed(this.message);
}

class GetAllNotificationsSuccessfully extends NotificationState {
  final List<Notifications> notifs;
  const GetAllNotificationsSuccessfully(this.notifs);
}

class GetAllNotificationsFailed extends NotificationState {
  final String message;
  const GetAllNotificationsFailed(this.message);
}

class DeleteNotificationSuccessfully extends NotificationState {
  const DeleteNotificationSuccessfully();
}

class DeleteNotificationFailed extends NotificationState {
  final String message;
  const DeleteNotificationFailed(this.message);
}

class UpdateNotificationSuccessfully extends NotificationState {
  const UpdateNotificationSuccessfully();
}

class UpdateNotificationFailed extends NotificationState {
  final String message;
  const UpdateNotificationFailed(this.message);
}
