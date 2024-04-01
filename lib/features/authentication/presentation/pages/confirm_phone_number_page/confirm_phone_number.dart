import 'package:flutter/material.dart';
import 'package:yourmanager/features/authentication/presentation/pages/confirm_phone_number_page/confirm_phone_number_small_screen.dart';

class ConfirmPhonenumber extends StatefulWidget {
  const ConfirmPhonenumber({super.key});

  @override
  State<ConfirmPhonenumber> createState() => _ConfirmPhonenumberState();
}

class _ConfirmPhonenumberState extends State<ConfirmPhonenumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 768) {
        return const ConfirmPhoneNumberSmallScreen(
          number: "+212772374621",
        );
      } else {
        return Container();
      }
    }));
  }
}
