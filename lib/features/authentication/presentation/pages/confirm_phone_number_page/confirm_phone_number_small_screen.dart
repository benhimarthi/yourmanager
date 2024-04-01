import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../core/util/app_colors.dart';
import '../../widgets/big_text_format.dart';
import '../../widgets/textinput_decoration.dart';

class ConfirmPhoneNumberSmallScreen extends StatefulWidget {
  final number;
  const ConfirmPhoneNumberSmallScreen({super.key, this.number});
  @override
  State<ConfirmPhoneNumberSmallScreen> createState() =>
      _ConfirmPhoneNumberSmallScreenState();
}

class _ConfirmPhoneNumberSmallScreenState
    extends State<ConfirmPhoneNumberSmallScreen> {
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
              child: const BigText(content: 'Phone number checking'),
            ),
            SizedBox(
                width: double.infinity,
                child: Text.rich(TextSpan(
                    text: "we have send you an SMS with a confirmation code"
                        " to this number: ",
                    children: <TextSpan>[
                      TextSpan(
                          text: "${widget.number}",
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        focusColor: onFocusTextFieldBorderColor,
                        hintText: "Confirmation code",
                        hintStyle: const TextStyle(
                            color: onUnFocusTextFieldBorderColor),
                      ),
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
                    text: "00 : 52 : ",
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
            )
          ],
        ),
      ),
    );
  }
}
