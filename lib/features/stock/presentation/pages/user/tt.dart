import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Tests extends StatefulWidget {
  const Tests({super.key});

  @override
  State<Tests> createState() => _TestsState();
}

class _TestsState extends State<Tests> {
  List<mod> myMods = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int n = 0; n < 3; n++) {
      myMods.add(mod(n.toString(), (n * myMods.length).toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
          child: Column(
        children: List.generate(myMods.length, (index) {
          return ListTile(
            title: Text(myMods[index].name),
            subtitle: Text(myMods[index].cat),
          );
        }),
      )),
    );
  }
}

class mod {
  final String name;
  final String cat;

  mod(this.name, this.cat);
}
