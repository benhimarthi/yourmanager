import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/notifications/domain/entities/notification.dart';
import 'package:yourmanager/features/notifications/domain/repositories/notification_repository.dart';

class GetNotification extends UseCaseWithParam<Notifications, String> {
  final NotificationRepository _repository;

  GetNotification(this._repository);

  @override
  ResultFuture<Notifications> call(String params) {
    return _repository.getNotification(params);
  }
}
