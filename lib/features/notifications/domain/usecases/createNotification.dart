import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/notifications/domain/entities/notification.dart';
import 'package:yourmanager/features/notifications/domain/repositories/notification_repository.dart';

class CreateNotification
    extends UseCaseWithParam<Notifications, CreateNotificationParams> {
  final NotificationRepository _repository;
  CreateNotification(this._repository);

  @override
  ResultFuture<Notifications> call(CreateNotificationParams params) {
    return _repository.createNotification(
      params.title,
      params.message,
      params.link,
      params.viewed,
      params.time,
    );
  }
}

class CreateNotificationParams {
  final String title;
  final String message;
  final String link;
  final bool viewed;
  final DateTime time;

  CreateNotificationParams({
    required this.title,
    required this.message,
    required this.link,
    required this.viewed,
    required this.time,
  });
}
