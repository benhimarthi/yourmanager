import 'package:bloc/bloc.dart';
import 'package:yourmanager/features/authentication/domain/usecases/admin/black_list_user.dart';
import 'package:yourmanager/features/authentication/domain/usecases/admin/delete_user_account.dart';
import 'package:yourmanager/features/authentication/domain/usecases/admin/get_all_black_lisetd_users.dart';
import 'package:yourmanager/features/authentication/domain/usecases/admin/get_all_users.dart';
import 'package:yourmanager/features/authentication/domain/usecases/admin/get_user.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/admin/user_admin_manager_state.dart';

class UserAdminManagerCubit extends Cubit<UserAdminManagerState> {
  final GetUser _getUser;
  final GetAllUsers _allUsers;
  final BlackListUser _blackListUser;
  final DeleteUserAccount _deleteUserAccount;
  final GetAllBlackListedUser _getAllBlackListedUser;

  UserAdminManagerCubit({
    required GetUser getUser,
    required GetAllUsers allUsers,
    required BlackListUser blackListUser,
    required DeleteUserAccount deleteUserAccount,
    required GetAllBlackListedUser getAllBlackListedUser,
  })  : _getUser = getUser,
        _allUsers = allUsers,
        _blackListUser = blackListUser,
        _deleteUserAccount = deleteUserAccount,
        _getAllBlackListedUser = getAllBlackListedUser,
        super(const UserAdminManagerInitial());

  Future<void> getUser(String id) async {
    final result = await _getUser(id);
    result.fold(
      (failure) => emit(const GetUserFailed(
          "Sorry we couldn't get this user, please try again!")),
      (user) => emit(GetUserSuccessfully(user)),
    );
  }

  Future<void> getAllUsers() async {
    emit(const IsGettingTheUsers());
    final result = await _allUsers();
    result.fold(
      (failure) => emit(const GetAllUsersFailed(
          "Sorry we couldn't get the users, please try again!")),
      (user) => emit(GetAllUsersSuccessfully(user)),
    );
  }

  Future<void> blacklistUser(String id) async {
    final result = await _blackListUser(id);
    result.fold(
      (failure) => emit(const BlackListUserFailed(
          "Sorry, we couldn't black list this user, please try again!")),
      (_) => emit(const BlackListUserSuccessfully()),
    );
  }

  Future<void> deleteUserAccount(String id) async {
    final result = await _deleteUserAccount(id);
    result.fold(
      (failure) => emit(const DeleteUserAccountFailed(
          "Sorry, a problem occured while trying to delete this user account, please try later!.")),
      (user) => emit(const DeleteUserAccountSuccessfully()),
    );
  }

  Future<void> getAllBlackListedUsers() async {
    final result = await _getAllBlackListedUser();
    result.fold(
      (failure) => emit(const GetAllBlackListedUserFailed(
          "Sorry, a problem occured while trying to get the black listed users!.")),
      (user) => emit(GetAllBlackListedUserSuccessfully(user)),
    );
  }
}
