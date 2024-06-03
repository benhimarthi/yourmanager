import 'package:flutter/material.dart';

class ProfileViewSmallScreen extends StatefulWidget {
  const ProfileViewSmallScreen({super.key});

  @override
  State<ProfileViewSmallScreen> createState() => _ProfileViewSmallScreenState();
}

class _ProfileViewSmallScreenState extends State<ProfileViewSmallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 87, 144, 171),
        elevation: 0,
        title: const Text('Profile'),
        actions: [
          GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: const [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 217, 217, 217),
                ),
                Icon(
                  Icons.edit,
                  color: Colors.blue,
                )
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: const Color.fromARGB(0, 255, 193, 7),
                height: 260,
              ),
              Positioned(
                top: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 220,
                  color: const Color.fromARGB(255, 87, 144, 171),
                ),
              ),
              Positioned(
                top: 45,
                child: Container(
                  width: 214,
                  height: 214,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(107),
                    color: const Color.fromARGB(255, 213, 213, 213),
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 100,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.5),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.photo_camera,
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
