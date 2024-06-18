import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourmanager/core/util/app_colors.dart';
import 'package:yourmanager/core/util/change_screen_mang.dart';
import 'package:yourmanager/core/util/current_user_informations.dart';
import 'package:yourmanager/core/widgets/big_text_format.dart';
import 'package:yourmanager/core/widgets/textinput_decoration.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:yourmanager/features/authentication/presentation/pages/register_page/register_page.dart';
import 'package:yourmanager/features/sale/presentation/pages/home_page_small_screen.dart';

import '../../../../../core/util/mail_address_validator.dart';
import '../../cubit/authentication_state.dart';

class LoginS extends StatefulWidget {
  const LoginS({super.key});

  @override
  State<LoginS> createState() => _LoginSState();
}

class _LoginSState extends State<LoginS> {
  int ind = 0;
  bool obscurePassword = true;
  late String mailAddress = "";
  late String password = "";
  static String? currentUserUid = "";
  final formKey = GlobalKey<FormState>();

  registerUserUid(String uid) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setString('user_uid', uid);
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  checkUser() async {
    try {
      SharedPreferences sf = await SharedPreferences.getInstance();
      currentUserUid = sf.getString('user_uid');

      if (currentUserUid != null) {
        userUID = currentUserUid!;
        nextScreenReplace(
            context,
            HomePage(
              userUid: currentUserUid!,
            ));
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginWithEmailAndPasswordFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is LoginWithEmailAndPasswordSuccessfully) {
          registerUserUid(state.myUser.user!.uid);
          nextScreenReplace(
            context,
            HomePage(
              userUid: state.myUser.user!.uid,
            ),
          );
        }
      },
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: double.maxFinite,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 67, 174, 237),
                Color.fromARGB(255, 15, 59, 85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 60),
                  width: MediaQuery.of(context).size.width * .99,
                  child: const Center(child: BigText(content: "YOUR MANAGER")),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  child: const BigText(content: 'Login to an account'),
                ),
                SizedBox(
                    width: double.infinity,
                    child: Text.rich(TextSpan(
                        text: "You don't have an account yet? ",
                        children: <TextSpan>[
                          TextSpan(
                              text: "Register",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor1,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  nextScreen(context, const Register());
                                })
                        ],
                        style: const TextStyle(color: textColor1)))),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            focusColor: onFocusTextFieldBorderColor,
                            hintText: "User name",
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(137, 255, 255, 255)),
                            prefixIcon: const Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                          ),
                          validator: (value) {
                            if (!isValidEmail(value!)) {
                              return "this mail address is invalid";
                            } else {
                              return null;
                            }
                          },
                          onTap: () {
                            setState(() {
                              ind = 2;
                            });
                          },
                          onTapOutside: (event) {
                            setState(() {
                              ind = 0;
                            });
                          },
                          onChanged: (v) {
                            setState(() {
                              mailAddress = v;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: obscurePassword,
                          decoration: textInputDecoration.copyWith(
                            focusColor: onFocusTextFieldBorderColor,
                            hintText: "Password",
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(171, 255, 255, 255)),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscurePassword =
                                      obscurePassword == true ? false : true;
                                });
                              },
                              child: obscurePassword
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: onUnFocusTextFieldBorderColor,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: onUnFocusTextFieldBorderColor,
                                    ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.length < 6) {
                              return "Password must be at least 6 character";
                            } else {
                              return null;
                            }
                          },
                          onTap: () {
                            setState(() {
                              ind = 2;
                            });
                          },
                          onTapOutside: (event) {
                            setState(() {
                              ind = 0;
                            });
                          },
                          onChanged: (v) {
                            setState(() {
                              password = v;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text.rich(
                    TextSpan(
                        text: "You forgot your password? ",
                        children: <TextSpan>[
                          TextSpan(
                              text: "Renew",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor1,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()..onTap = () {})
                        ],
                        style: const TextStyle(color: textColor1)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => bntColor)),
                    onPressed: () {
                      login();
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: Center(
                        child: Text("Login"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  login() {
    if (formKey.currentState!.validate()) {
      context
          .read<AuthenticationCubit>()
          .loginWithEmailAndPassword(mailAddress, password);
    }
  }
}
