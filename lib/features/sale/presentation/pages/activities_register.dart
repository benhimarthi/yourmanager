import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ActivitiesRegister extends StatefulWidget {
  const ActivitiesRegister({super.key});

  @override
  State<ActivitiesRegister> createState() => _ActivitiesRegisterState();
}

class _ActivitiesRegisterState extends State<ActivitiesRegister> {
  String _scanBarcodeResult = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0,
          title: const Text("YOURMANAGER"),
          actions: const [
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 217, 217, 217),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            //color: Colors.red,
            width: double.infinity,
            height: 450,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255)),
                    child: Center(
                        child: Text(
                      'Register Cell',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    )),
                  ),
                ),
                Visibility(
                  visible: false,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 217, 217, 217),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            width: 160,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    scanBarcodeNormal();
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: const [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            Color.fromARGB(159, 255, 255, 255),
                                      ),
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                        child: Center(
                                            child:
                                                Icon(Icons.qr_code_2_outlined)),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text('scan barecode')
                              ],
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 150,
                            child: ListView(
                                padding: const EdgeInsets.all(5),
                                scrollDirection: Axis.horizontal,
                                children: [item(), item(), item(), item()])),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255)),
                    child: Center(
                        child: Text(
                      'Register Expense',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    )),
                  ),
                ),
                Visibility(
                  visible: true,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 217, 217, 217),
                    ),
                    child: Column(
                      children: const [
                        TextField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Expense title'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Amount'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget item({String imgLink = "", String name = 'product name'}) {
    return Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Center(
                child: Icon(Icons.inbox_rounded),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(7),
              child: Center(child: Text(name)),
            )
          ],
        ));
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcodeResult = barcodeScanRes;
    });
  }
}
