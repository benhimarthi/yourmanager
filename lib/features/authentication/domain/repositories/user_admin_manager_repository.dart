import 'package:yourmanager/core/util/typedef.dart';

import '../entities/users.dart';

abstract class UserAdminManagerRepository {
  ResultFuture<Users> getUser(String id);
  ResultFuture<List<Users>> getAllUsers();
  ResultVoid blacklistUser(String id);
  ResultVoid deleteUserAccount(String id);
}
