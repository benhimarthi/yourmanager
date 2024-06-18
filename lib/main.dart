import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:yourmanager/features/authentication/presentation/pages/confirm_phone_number_page/confirm_phone_number.dart';
import 'package:yourmanager/features/authentication/presentation/pages/login_page/login_page.dart';
import 'package:yourmanager/features/balance_sheet/domain/entities/balance_sheet.dart';
import 'package:yourmanager/features/categories/presentation/cubit/product_category_cubit.dart';
import 'package:yourmanager/features/expenditure/presentation/cubit/expenditure_cubit_manager.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_cubit.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_cubit.dart';
import 'package:yourmanager/features/sale/presentation/cubit/sale_manager_cubit.dart';
import 'package:yourmanager/features/sale/presentation/pages/home_page_small_screen.dart';
import 'package:yourmanager/features/sale/presentation/pages/sales_main_page.dart';
import 'package:yourmanager/features/sale/presentation/pages/windows_alert_view.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/admin/stock_admin_cubit.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/stock_manager_cubit.dart';
import 'package:yourmanager/features/stock/presentation/pages/admin_pages/stock_main_view.dart';
import 'package:yourmanager/firebase_options.dart';
import 'core/services/injection_container.dart';
import 'features/authentication/presentation/cubit/admin/user_admin_manager_cubit.dart';
import 'features/authentication/presentation/pages/register_page/register_page.dart';
import 'features/authentication/presentation/pages/register_page/register_page_small_screen.dart';
import 'features/categories/presentation/pages/cate_test.dart';
import 'features/product/presentation/pages/add_product_view.dart';
import 'features/balance_sheet/presentation/pages/blanace_sheet_page.dart';
import 'features/product/presentation/pages/product_details.dart';
import 'features/sale/presentation/pages/activities_register.dart';
import 'features/stock/presentation/pages/admin_pages/product_profile_components/product_profile_admin_small_screen.dart';
import 'features/stock/presentation/pages/user/tt.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  runApp(const MyApp());
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ActivitiesRegister(),
  );
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
        BlocProvider<UserAdminManagerCubit>(
            create: (context) => sl<UserAdminManagerCubit>()),
        BlocProvider<RepresentationCubit>(
          create: (context) => sl<RepresentationCubit>(),
        ),
        BlocProvider<ProductManagerCubit>(
          create: (context) => sl<ProductManagerCubit>(),
        ),
        BlocProvider<ProductCategoryCubit>(
          create: (context) => sl<ProductCategoryCubit>(),
        ),
        BlocProvider<StockAdminCubit>(
          create: (context) => sl<StockAdminCubit>(),
        ),
        BlocProvider<StockManagerCubit>(
          create: (context) => sl<StockManagerCubit>(),
        ),
        BlocProvider<ExpenditureCubit>(
          create: (context) => sl<ExpenditureCubit>(),
        ),
        BlocProvider<SaleManagerCubit>(
          create: (context) => sl<SaleManagerCubit>(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
