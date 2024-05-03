import 'package:flutter/material.dart';
import 'package:yourmanager/core/util/change_screen_mang.dart';
import 'package:yourmanager/features/sale/presentation/pages/home_view_small_screen.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({super.key});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        actions: [
          Container(
            margin: const EdgeInsets.all(1),
            //color: Colors.amber,
            width: MediaQuery.of(context).size.width * .9,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * .8,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 207, 207, 207),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                    child: Stack(
                  alignment: Alignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 93, 93, 93),
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: "Search...",
                      ),
                    )
                  ],
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
