import 'package:flutter/material.dart';
import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';

import '../repositories/notification_repository.dart';

class DeleteNotification extends UseCaseWithParam<void, String> {
  final NotificationRepository _repository;

  DeleteNotification(this._repository);

  @override
  ResultFuture<void> call(String params) {
    return _repository.deleteNotification(params);
  }
}
