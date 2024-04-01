import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/authentication_state.dart';
import 'package:yourmanager/features/authentication/presentation/pages/confirm_phone_number_page/confirm_phone_number_small_screen.dart';
import 'package:yourmanager/features/authentication/presentation/pages/register_page/register_page_small_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth <= 768) {
            return state is WaitingConfirmationCode
                ? const ConfirmPhoneNumberSmallScreen()
                : const RegisterPageSmallScreen();
          } else {
            return Container();
          }
        }));
      },
    );
  }
}
/**/