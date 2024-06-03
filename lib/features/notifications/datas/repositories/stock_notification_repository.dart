import 'package:dartz/dartz.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/core/errors/failure.dart';
import 'package:yourmanager/features/notifications/datas/data_source/notification_remote_data_source.dart';
import 'package:yourmanager/features/notifications/domain/entities/notification.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/notifications/domain/repositories/notification_repository.dart';
import 'package:yourmanager/features/stock/data/stock_remote_data_source/stock_remote_data_src.dart';

class StockNotificationRepository extends NotificationRepository {
  final NotificationRemoteDataSource _dataSource;

  StockNotificationRepository(this._dataSource);

  @override
  ResultFuture<Notifications> createNotification(String title, String message,
      String link, bool viewed, DateTime time) async {
    try {
      final result = await _dataSource.createNotification(
        title,
        message,
        link,
        time,
        viewed,
      );
      return right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteNotification(String id) async {
    try {
      final result = await _dataSource.deleteNotification(id);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Notifications>> getAllNotifications() async {
    try {
      final allNotifs = await _dataSource.getAllNotifications();
      return Right(allNotifs);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Notifications> getNotification(String id) async {
    try {
      final notif = await _dataSource.getNotification(id);
      return Right(notif);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateNotification(String id, bool view) async {
    try {
      final result = await _dataSource.updateNotification(id, view);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
