import 'package:yourmanager/core/util/typedef.dart';

import '../entities/users.dart';

abstract class UserAdminManagerRepository {
  ResultFuture<Users> getUser(String id);
  ResultFuture<List<Users>> getAllUsers();
  ResultVoid blacklistUser(String id);
  ResultFuture<List<String>> getAllBlackLisetdUser();
  ResultVoid deleteUserAccount(String id);
}
