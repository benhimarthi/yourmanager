import 'package:bloc/bloc.dart';
import 'package:yourmanager/features/notifications/domain/usecases/createNotification.dart';
import 'package:yourmanager/features/notifications/domain/usecases/delete_notification.dart';
import 'package:yourmanager/features/notifications/domain/usecases/get_all_notifications.dart';
import 'package:yourmanager/features/notifications/domain/usecases/get_notification.dart';
import 'package:yourmanager/features/notifications/domain/usecases/update_notification.dart';

import '../../domain/entities/notification.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final CreateNotification _createNotification;
  final GetNotification _getNotification;
  final GetAllNotifications _getAllNotifications;
  final DeleteNotification _deleteNotification;
  final UpdateNotification _updateNotification;

  NotificationCubit({
    required CreateNotification createNotification,
    required GetNotification getNotification,
    required GetAllNotifications getAllNotifications,
    required DeleteNotification deleteNotification,
    required UpdateNotification updateNotification,
  })  : _createNotification = createNotification,
        _getNotification = getNotification,
        _getAllNotifications = getAllNotifications,
        _deleteNotification = deleteNotification,
        _updateNotification = updateNotification,
        super(const NotificationInitial());

  Future<void> createNotification(
    String title,
    String message,
    String link,
    bool viewed,
    DateTime time,
  ) async {
    final result = await _createNotification(CreateNotificationParams(
        title: title,
        message: message,
        link: link,
        viewed: viewed,
        time: time));
    result.fold(
        (failure) => emit(const NotificationCreationFailed(
            'A problem occure while trying to create the notification.')),
        (notif) => emit(NotificationCreatedSuccessfully(notif)));
  }

  Future<void> getNotification(String id) async {
    final result = await _getNotification(id);
    result.fold(
        (failure) => emit(const GetNotificationFailed(
            'A problem occure while trying to get the notification.')),
        (notif) => emit(GetNotificationSuccessfully(notif)));
  }

  Future<void> getAllNotifications() async {
    final result = await _getAllNotifications();
    result.fold(
        (failure) => emit(const GetAllNotificationsFailed(
            'A problem occure while trying to get the notifications.')),
        (notifs) => emit(GetAllNotificationsSuccessfully(notifs)));
  }

  Future<void> deleteNotification(String id) async {
    final result = await _deleteNotification(id);
    result.fold(
        (failure) => emit(const DeleteNotificationFailed(
            'A problem occure while trying to delete the notification.')),
        (_) => emit(const DeleteNotificationSuccessfully()));
  }

  Future<void> updateNotification(String id, bool view) async {
    final result = await _updateNotification(
        UpdateNotificationParam(id: id, viewed: view));
    result.fold(
        (failure) => emit(const UpdateNotificationFailed(
            'A problem occure while trying to update the notification.')),
        (notif) => emit(const UpdateNotificationSuccessfully()));
  }
}
