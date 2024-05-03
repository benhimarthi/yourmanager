import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/authentication_state.dart';

import '../../../../../core/util/app_colors.dart';
import '../../../../../core/util/phone_number_validator.dart';
import '../../../domain/entities/users.dart';
import '../../../../../core/widgets/big_text_format.dart';
import '../../../../../core/widgets/textinput_decoration.dart';

class RegisterPageSmallScreen extends StatefulWidget {
  const RegisterPageSmallScreen({super.key});

  @override
  State<RegisterPageSmallScreen> createState() =>
      _RegisterPageSmallScreenState();
}

class _RegisterPageSmallScreenState extends State<RegisterPageSmallScreen> {
  int ind = 0;
  bool obscurePassword = true;
  bool obscurePasswordC = true;

  String fullName = "";
  String phoneNumber = "";
  String password = "";
  String confirmPassword = "";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is AuthenticationWithGoogleSuccessfull) {
          print(state.users.fullName);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.users.fullName)));
        }
        if (state is AuthenticationWithGoogleFailed) {
          print(state.message);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: double.maxFinite,
          padding: const EdgeInsets.all(20),
          color: backgroundColor,
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
                  child: const BigText(content: 'Register an account'),
                ),
                SizedBox(
                    width: double.infinity,
                    child: Text.rich(TextSpan(
                        text: "You already have an account? ",
                        children: <TextSpan>[
                          TextSpan(
                              text: "Login",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor1,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()..onTap = () {})
                        ],
                        style: const TextStyle(color: textColor1)))),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        context
                            .read<AuthenticationCubit>()
                            .getUserInformationsFromGoogle();
                      });
                    },
                    child: const Text("Google"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        InternationalPhoneNumberInput(
                          textStyle: const TextStyle(color: textColor1),
                          onInputChanged: (PhoneNumber number) {
                            setState(() {
                              phoneNumber = number.phoneNumber!;
                            });
                          },
                          inputDecoration: textInputDecoration.copyWith(
                            focusColor: onFocusTextFieldBorderColor,
                            hintText: "Phone number",
                            hintStyle: const TextStyle(
                                color: onUnFocusTextFieldBorderColor),
                          ),
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          validator: (nb) {
                            String phoneNb = nb!.trim();
                            if (isValidPhoneNumber(phoneNb)) {
                              return "Invalid phone number: $phoneNb";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: obscurePassword,
                          decoration: textInputDecoration.copyWith(
                            focusColor: onFocusTextFieldBorderColor,
                            hintText: "Full name",
                            hintStyle: const TextStyle(
                                color: onUnFocusTextFieldBorderColor),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: onUnFocusTextFieldBorderColor,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please insert a valid name.";
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
                          onChanged: (value) {
                            setState(() {
                              fullName = value;
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
                                color: onUnFocusTextFieldBorderColor),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: onUnFocusTextFieldBorderColor,
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
                            } else if (confirmPassword.isNotEmpty &&
                                confirmPassword != value) {
                              return "the password must match the confirmation password.";
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
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: obscurePasswordC,
                          decoration: textInputDecoration.copyWith(
                            focusColor: onFocusTextFieldBorderColor,
                            hintText: "Confirm password",
                            hintStyle: const TextStyle(
                                color: onUnFocusTextFieldBorderColor),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: onUnFocusTextFieldBorderColor,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscurePasswordC =
                                      obscurePasswordC == true ? false : true;
                                });
                              },
                              child: obscurePasswordC
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
                            } else if (password.isNotEmpty &&
                                password != value) {
                              return "The confirmation password doesn't match with the actual password";
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
                          onChanged: (value) {
                            setState(() {
                              confirmPassword = value;
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
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => bntColor)),
                    onPressed: () {
                      setState(() {
                        checkPhoneNumber();
                      });
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: Center(
                        child: Text("Register"),
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

  void checkPhoneNumber() {
    if (formKey.currentState!.validate()) {
      context.read<AuthenticationCubit>().verifyPhoneNumber(
          phoneNumber,
          (p0) => null,
          (p0) => null,
          (p0) => null,
          Users(
            fullName: fullName,
            id: '',
            password: password,
            phoneNumber: phoneNumber,
          ));
    }
  }
}
