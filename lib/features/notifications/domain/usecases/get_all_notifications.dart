import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/notifications/domain/entities/notification.dart';
import 'package:yourmanager/features/notifications/domain/repositories/notification_repository.dart';

class GetAllNotifications extends UseCaseWithoutParam<List<Notifications>> {
  final NotificationRepository _repository;

  GetAllNotifications(this._repository);

  @override
  ResultFuture<List<Notifications>> call() {
    return _repository.getAllNotifications();
  }
}
