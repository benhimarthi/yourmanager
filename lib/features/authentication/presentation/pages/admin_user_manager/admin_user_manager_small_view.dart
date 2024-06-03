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
  @override
  void initState() {
    super.initState();
    context.read<UserAdminManagerCubit>().getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserAdminManagerCubit, UserAdminManagerState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: state is IsGettingTheUsers
              ? const Center(
                  child: LoadingColumn(
                    message: 'Charging Users',
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
        if (state is GetAllUsersFailed) {
          print(state.message);
        }
      },
    );
  }
}

Widget userItem(Users user) {
  return ListTile(
    title: Text(user.fullName),
    subtitle: Text(user.email),
    leading: CCircleAvatar(
      icon: Icons.person,
      imagePath: user.image,
    ),
  );
}
