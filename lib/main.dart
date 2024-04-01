import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:yourmanager/features/authentication/presentation/pages/confirm_phone_number_page/confirm_phone_number.dart';
import 'package:yourmanager/features/authentication/presentation/pages/login_page/login_page.dart';
import 'package:yourmanager/firebase_options.dart';
import 'core/services/injection_container.dart';
import 'features/authentication/presentation/pages/register_page/register_page.dart';
import 'features/authentication/presentation/pages/register_page/register_page_small_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthenticationCubit>(),
      child: const MaterialApp(
        home: Register(),
      ),
    );
  }
}
