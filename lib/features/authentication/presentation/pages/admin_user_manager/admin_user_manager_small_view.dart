import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/admin/user_admin_manager_cubit.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/admin/user_admin_manager_state.dart';
import 'package:yourmanager/features/img_vids/presentation/widgets/custom_circle_avatar.dart';

import '../../../../../core/widgets/loading.dart';

class AdminUserManagerSmallScreen extends StatefulWidget {
  const AdminUserManagerSmallScreen({super.key});

  @override
  State<AdminUserManagerSmallScreen> createState() =>
      _AdminUserManagerSmallScreenState();
}

class _AdminUserManagerSmallScreenState
    extends State<AdminUserManagerSmallScreen> {
  late List<String> blackListedUsers;
  @override
  void initState() {
    super.initState();
    blackListedUsers = [];
    context.read<UserAdminManagerCubit>().getAllUsers();
    context.read<UserAdminManagerCubit>().getAllBlackListedUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserAdminManagerCubit, UserAdminManagerState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: state is IsGettingTheUsers
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: LoadingColumn(
                      message: 'Charging Users',
                    ),
                  ),
                )
              : state is GetAllUsersSuccessfully
                  ? Column(
                      children: List.generate(state.myUsers.length,
                          (index) => userItem(state.myUsers[index])),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            context.read<UserAdminManagerCubit>().getAllUsers();
                          },
                          icon: const Icon(Icons.replay),
                        ),
                      )),
        );
      },
      listener: (context, state) {
        if (state is GetAllUsersFailed) {}
        if (state is GetAllBlackListedUserSuccessfully) {
          print("We got all the black listed user.");
          blackListedUsers = state.myUsers;
        }
      },
    );
  }

  Widget userItem(Users user) {
    return GestureDetector(
      onTap: () {},
      child: ListTile(
        title: Text(
          user.fullName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        subtitle: Text(
          user.email,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        leading: CCircleAvatar(
          icon: Icons.person,
          imagePath: user.image,
        ),
        trailing: blackListedUsers.contains(user.id)
            ? const Text(
                'Blocked',
                style: TextStyle(color: Colors.red),
              )
            : const Text(
                'Active',
                style: TextStyle(color: Colors.green),
              ),
      ),
    );
  }
}
