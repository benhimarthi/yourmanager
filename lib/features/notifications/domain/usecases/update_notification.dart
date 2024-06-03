import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/notifications/domain/repositories/notification_repository.dart';

class UpdateNotification
    extends UseCaseWithParam<void, UpdateNotificationParam> {
  final NotificationRepository _repository;

  UpdateNotification(this._repository);

  @override
  ResultFuture<void> call(UpdateNotificationParam params) {
    return _repository.updateNotification(params.id, params.viewed);
  }
}

class UpdateNotificationParam {
  final String id;
  final bool viewed;

  UpdateNotificationParam({
    required this.id,
    required this.viewed,
  });
}
