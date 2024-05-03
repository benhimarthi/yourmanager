import 'package:flutter/material.dart';
import 'package:yourmanager/core/util/change_screen_mang.dart';
import 'package:yourmanager/features/sale/presentation/pages/sales_main_screen_small_screen.dart';
import 'package:yourmanager/features/sale/presentation/pages/search_view_small_page.dart';

import 'home_view_small_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeViewSmallScreen(),
    SaleMainPageSmallScreen(),
    Text('Profile Page'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "YOUR MANAGER",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(context, const SearchPageView());
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  )),
              Positioned(
                  top: 20,
                  left: 26,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(3)),
                  )),
            ],
          ),
          GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: const [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.blue,
                )
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 20),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined, size: 20),
            label: 'Sales',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory, size: 20),
            label: 'Inventory',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
