import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:yourmanager/features/authentication/presentation/pages/confirm_phone_number_page/confirm_phone_number.dart';
import 'package:yourmanager/features/authentication/presentation/pages/login_page/login_page.dart';
import 'package:yourmanager/features/balance_sheet/domain/entities/balance_sheet.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_cubit.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_cubit.dart';
import 'package:yourmanager/features/sale/presentation/cubit/sale_manager_cubit.dart';
import 'package:yourmanager/features/sale/presentation/pages/home_page_small_screen.dart';
import 'package:yourmanager/features/sale/presentation/pages/sales_main_page.dart';
import 'package:yourmanager/features/stock/presentation/pages/stock_main_view.dart';
import 'package:yourmanager/firebase_options.dart';
import 'core/services/injection_container.dart';
import 'features/authentication/presentation/pages/register_page/register_page.dart';
import 'features/authentication/presentation/pages/register_page/register_page_small_screen.dart';
import 'features/product/presentation/pages/add_product_view.dart';
import 'features/sale/presentation/pages/blanace_sheet_page.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
            create: (context) => sl<AuthenticationCubit>()),
        BlocProvider<RepresentationCubit>(
          create: (context) => sl<RepresentationCubit>(),
        ),
        BlocProvider<ProductManagerCubit>(
          create: (context) => sl<ProductManagerCubit>(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StockMainView(),
      ),
    );
  }
}
