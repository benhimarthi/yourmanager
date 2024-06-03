import 'package:equatable/equatable.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';

class UserAdminManagerState extends Equatable {
  const UserAdminManagerState();
  @override
  List<Object?> get props => [];
}

class UserAdminManagerInitial extends UserAdminManagerState {
  const UserAdminManagerInitial();
}

class GetUserSuccessfully extends UserAdminManagerState {
  final Users myUsers;
  const GetUserSuccessfully(this.myUsers);
}

class GetUserFailed extends UserAdminManagerState {
  final String message;
  const GetUserFailed(this.message);
}

class IsGettingTheUsers extends UserAdminManagerState {
  const IsGettingTheUsers();
}

class GetAllUsersSuccessfully extends UserAdminManagerState {
  final List<Users> myUsers;
  const GetAllUsersSuccessfully(this.myUsers);
}

class GetAllUsersFailed extends UserAdminManagerState {
  final String message;
  const GetAllUsersFailed(this.message);
}

class BlackListUserSuccessfully extends UserAdminManagerState {
  const BlackListUserSuccessfully();
}

class BlackListUserFailed extends UserAdminManagerState {
  final String message;
  const BlackListUserFailed(this.message);
}

class DeleteUserAccountSuccessfully extends UserAdminManagerState {
  const DeleteUserAccountSuccessfully();
}

class DeleteUserAccountFailed extends UserAdminManagerState {
  final String message;
  const DeleteUserAccountFailed(this.message);
}
