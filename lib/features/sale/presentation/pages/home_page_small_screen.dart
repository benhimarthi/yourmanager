import 'package:flutter/material.dart';
import 'package:yourmanager/core/util/change_screen_mang.dart';
import 'package:yourmanager/features/authentication/presentation/pages/profile/profile_main_screen.dart';
import 'package:yourmanager/features/notifications/presentation/pages/notification_main_view.dart';
import 'package:yourmanager/features/sale/presentation/pages/sales_main_screen_small_screen.dart';
import 'package:yourmanager/features/sale/presentation/pages/search_view_small_page.dart';
import 'package:yourmanager/features/stock/presentation/pages/stock_main_view.dart';

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
    StockMainView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: _selectedIndex == 0 ? true : false,
        child: GestureDetector(
          onTap: () {
            /*requestOverlay();
            startBubble(
                bubbleOptions: BubbleOptions(
              bubbleIcon: 'test',
              bubbleSize: 45,
              enableClose: true,
              distanceToClose: 90,
              enableAnimateToEdge: true,
              enableBottomShadow: true,
              keepAliveWhenAppExit: true,
            )
            );*/
          },
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 24,
            child: Icon(Icons.add),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 5,
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
                  onPressed: () {
                    nextScreen(context, const NotificationMainView());
                  },
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
            onTap: () {
              nextScreen(context, const ProfileMainPage());
            },
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
                  child: Icon(Icons.person),
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

  /*Future<void> requestOverlay() async {
    final isGranted = await DashBubble.instance.requestOverlayPermission();
    if (isGranted) {
      print("Permission granted");
    } else {
      print("Permission request declined");
    }
  }

  Future<void> startBubble({
    BubbleOptions? bubbleOptions,
    VoidCallback? onTap,
  }) async {
    final hasStarted = await DashBubble.instance.startBubble(
      bubbleOptions: bubbleOptions,
      onTap: onTap,
    );
    if (hasStarted) {
      print("bubble start");
    } else {
      print("not started");
    }
  }

  Future<void> stopBubble() async {
    final hasStopped = await DashBubble.instance.stopBubble();
  }*/
}
