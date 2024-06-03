import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:yourmanager/core/widgets/screen_separator.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/admin/stock_admin_cubit.dart';

import '../../../img_vids/presentation/cubit/representation_cubit.dart';
import '../../../img_vids/presentation/cubit/representation_state.dart';
import '../Cubit/admin/stock_admin_state.dart';

class ProductProfileAdminSmallScreen extends StatefulWidget {
  //late String productId;
  const ProductProfileAdminSmallScreen({super.key});

  @override
  State<ProductProfileAdminSmallScreen> createState() =>
      _ProductProfileAdminSmallScreenState();
}

class _ProductProfileAdminSmallScreenState
    extends State<ProductProfileAdminSmallScreen> {
  late File? _imageFile;
  late String imageName;
  final picker = ImagePicker();

  final dataMap = <String, double>{
    "Quantity of users": 16,
  };
  final colorList = <Color>[
    Color.fromARGB(255, 255, 0, 0),
  ];

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        if (_imageFile!.path.isNotEmpty) {
          context.read<RepresentationCubit>().uploadImage(_imageFile!);
        }
      } else {
        print("No image selected!");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _imageFile = File('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        /*appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 67, 175, 237),
          elevation: 0,
          title: const Text("Product details"),
          actions: [],
        ),*/
        body: BlocConsumer<StockAdminCubit, StockAdminState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 67, 174, 237),
                      Color.fromARGB(255, 15, 59, 85),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 217, 217, 217),
                                borderRadius: BorderRadius.circular(75),
                                image: DecorationImage(
                                  image: FileImage(_imageFile!),
                                  fit: BoxFit.cover,
                                )),
                            child: Center(
                              child: _imageFile!.path.isEmpty
                                  ? const Icon(
                                      Icons.inventory,
                                      color: Colors.white,
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 20,
                            right: 125,
                            child: BlocConsumer<RepresentationCubit,
                                RepresentationState>(
                              listener: (context2, state) {
                                if (state is ImageUploadSuccessfully) {
                                  print(state.imageFile);
                                  imageName = state.imageFile;
                                }
                              },
                              builder: (context2, state) {
                                return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        getImage();
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 20,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ));
                              },
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Product name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    productProperty(
                      Icons.qr_code_2,
                      '1278378466213',
                      () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    productProperty(
                      Icons.category,
                      'Food',
                      () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    screenSeparator(),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: const Text(
                            'User percentage',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            width: 148,
                            height: 32,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Center(
                              child: Text('See the users'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: PieChart(
                          chartRadius: 120,
                          dataMap: dataMap,
                          colorList: const [Colors.white],
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValues: false,
                              showChartValueBackground: false,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: true,
                              chartValueStyle: TextStyle(color: Colors.white)),
                          centerWidget: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(131, 0, 0, 0),
                                    offset: Offset(.1, 3),
                                    blurRadius: 5,
                                  )
                                ]),
                            child: const Center(
                              child: Text(
                                "69.5 %",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          totalValue: 25,
                        ),
                      ),
                    ),
                    const Text(
                      "650 of 1500 users use this product.",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    screenSeparator(),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget productProperty(IconData preffixIcon, String value, onTapEdit) {
    return Container(
      padding: const EdgeInsets.all(4),
      width: MediaQuery.of(context).size.width * .85,
      height: 45,
      decoration: BoxDecoration(
          color: const Color.fromARGB(183, 255, 255, 255),
          borderRadius: BorderRadius.circular(50)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Icon(
              preffixIcon,
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: Center(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ),
        )
      ]),
    );
  }
}
