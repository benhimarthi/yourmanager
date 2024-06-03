import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/core/util/change_screen_mang.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/admin/user_admin_manager_cubit.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_cubit.dart';
import 'package:yourmanager/features/product/presentation/pages/add_product_view.dart';
import 'package:yourmanager/features/stock/presentation/pages/product_manager_view_small_screen.dart';
import '../../../authentication/presentation/pages/admin_user_manager/admin_user_manager_small_view.dart';

class StockMainViewSmallScreen extends StatefulWidget {
  const StockMainViewSmallScreen({super.key});

  @override
  State<StockMainViewSmallScreen> createState() =>
      _StockMainViewSmallScreenState();
}

class _StockMainViewSmallScreenState extends State<StockMainViewSmallScreen> {
  bool isLoadingProducts = true;
  bool displayReloadButton = false;
  bool load = true;
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    productManagerViewSmallScreen(),
    const AdminUserManagerSmallScreen(),
  ];
  @override
  void initState() {
    super.initState();
    context.read<ProductManagerCubit>().getAllProducts();
    context.read<UserAdminManagerCubit>().getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: const [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Center(child: Icon(Icons.person)),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          nextScreen(context, const AddProduct());
        },
        child: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: 30,
          child: const Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory, size: 20),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_sharp, size: 20),
            label: 'Users manager',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
