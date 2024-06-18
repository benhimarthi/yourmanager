import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/core/util/change_screen_mang.dart';
import 'package:yourmanager/core/widgets/custom_bottom_sheet.dart';
import 'package:yourmanager/features/authentication/data/models/user_model.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/authentication_state.dart';
import 'package:yourmanager/features/authentication/presentation/pages/profile/profile_main_screen.dart';
import 'package:yourmanager/features/img_vids/domain/entities/reprensentation.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_cubit.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_state.dart';
import 'package:yourmanager/features/img_vids/presentation/widgets/custom_circle_avatar.dart';
import 'package:yourmanager/features/notifications/presentation/pages/notification_main_view.dart';
import 'package:yourmanager/features/sale/presentation/pages/register_sell.dart';
import 'package:yourmanager/features/sale/presentation/pages/sales_main_screen_small_screen.dart';
import 'package:yourmanager/features/sale/presentation/pages/search_view_small_page.dart';
import 'package:yourmanager/features/stock/presentation/pages/admin_pages/stock_main_view.dart';
import 'package:yourmanager/features/stock/presentation/pages/user/add_product_to_user_stock.dart';
import '../../../stock/presentation/pages/user/user_stock_main_view.dart';
import 'home_view_small_screen.dart';

class HomePage extends StatefulWidget {
  final String userUid;
  const HomePage({super.key, required this.userUid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late UserModel user;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeViewSmallScreen(),
    SaleMainPageSmallScreen(),
    UserStockMainView(),
  ];
  @override
  void initState() {
    super.initState();
    user = const UserModel(
      id: '',
      fullName: '',
      phoneNumber: '',
      image: '',
      email: '',
    );
    getUserInformations();
  }

  getUserInformations() {
    context.read<AuthenticationCubit>().getUser(widget.userUid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: _selectedIndex == 0 || _selectedIndex == 2 ? true : false,
        child: GestureDetector(
          onTap: () async {
            if (_selectedIndex == 2) {
              nextScreen(context, const AddProductToUserStockView());
            } else {
              /**/
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 180,
                      padding: const EdgeInsets.all(5),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: ((context) => const RegisterSell()),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: const Text(
                                  "Register sale",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: const Text(
                                  "Register expenditure",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
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
              nextScreen(
                context,
                ProfileMainPage(
                  userUid: widget.userUid,
                ),
              );
            },
            child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
                listener: (context, state) {
              if (state is GetUserSuccessfully) {
                user = state.myUser;
              }
            }, builder: (context, state) {
              return state is GetUserSuccessfully
                  ? CCircleAvatar(
                      icon: Icons.person,
                      imagePath: state.myUser.image,
                    )
                  : CCircleAvatar(icon: Icons.person);
            }),
          ),
          const SizedBox(
            width: 15,
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
