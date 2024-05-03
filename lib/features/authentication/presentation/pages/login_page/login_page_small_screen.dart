import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:yourmanager/core/util/app_colors.dart';
import 'package:yourmanager/core/util/phone_number_validator.dart';
import 'package:yourmanager/core/widgets/big_text_format.dart';
import 'package:yourmanager/core/widgets/textinput_decoration.dart';

class LoginS extends StatefulWidget {
  const LoginS({super.key});

  @override
  State<LoginS> createState() => _LoginSState();
}

class _LoginSState extends State<LoginS> {
  int ind = 0;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
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
                          recognizer: TapGestureRecognizer()..onTap = () {})
                    ],
                    style: const TextStyle(color: textColor1)))),
            const SizedBox(
              height: 20,
            ),
            Form(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    InternationalPhoneNumberInput(
                      textStyle: const TextStyle(color: textColor1),
                      onInputChanged: (PhoneNumber number) {
                        // Do something with the entered phone number.
                        print(number);
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
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => bntColor)),
                onPressed: () {},
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
  }
}
