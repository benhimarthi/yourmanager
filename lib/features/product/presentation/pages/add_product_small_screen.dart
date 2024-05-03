import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/core/widgets/textinput_decoration.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_cubit.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_state.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_cubit.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_state.dart';
import 'package:image_picker/image_picker.dart';

class AddProductSmallScreen extends StatefulWidget {
  const AddProductSmallScreen({super.key});

  @override
  State<AddProductSmallScreen> createState() => _AddProductSmallScreenState();
}

class _AddProductSmallScreenState extends State<AddProductSmallScreen> {
  String title = "";
  String description = "";
  double mm = 0;
  double dd = 0;
  double yy = 0;
  double unitPrice = 0;
  double stockPrice = 0;
  final formKey = GlobalKey<FormState>();
  late File _imageFile;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print("No image selected!");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageFile = File("");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductManagerCubit, ProductManagerState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              "Add product",
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (formKey.currentState!.validate()) {
                      context.read<ProductManagerCubit>().addProduct(
                        title,
                        description,
                        "prod",
                        unitPrice,
                        stockPrice,
                        [],
                      );
                    }
                  });
                },
                child: Container(
                  height: 40,
                  width: 100,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 217, 217, 217),
                            borderRadius: BorderRadius.circular(75),
                            image: DecorationImage(
                              image: FileImage(_imageFile),
                              fit: BoxFit.cover,
                            )),
                        child: Center(
                          child: _imageFile.path.isEmpty
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
                            }
                          },
                          builder: (context2, state) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    getImage();
                                    if (_imageFile.path.isNotEmpty) {
                                      context2
                                          .read<RepresentationCubit>()
                                          .uploadImage(_imageFile);
                                    }
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
                  height: 60,
                ),
                const Text(
                  "Product informations",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(15),
                          child: TextFormField(
                            decoration: textInputDecoration.copyWith(
                                fillColor: Colors.transparent,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                                hintText: "product title",
                                hintStyle: const TextStyle(
                                  color: Color.fromARGB(98, 255, 255, 255),
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "the product title is mandatory";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              title = value;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15),
                          child: TextFormField(
                            maxLines: null,
                            decoration: textInputDecoration.copyWith(
                                fillColor: Colors.transparent,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                                hintText: "Add product description...",
                                hintStyle: const TextStyle(
                                  color: Color.fromARGB(98, 255, 255, 255),
                                )),
                            onChanged: (value) {
                              description = value;
                            },
                          ),
                        ),
                        const Text(
                          "Added date",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .25,
                              margin: const EdgeInsets.all(15),
                              child: TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  decoration: textInputDecoration.copyWith(
                                      fillColor: Colors.transparent,
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 1.5,
                                        ),
                                      ),
                                      hintText: "MM",
                                      hintStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(98, 255, 255, 255),
                                      )),
                                  onChanged: (value) {
                                    try {
                                      mm = double.parse(value);
                                    } catch (e) {
                                      mm = 0;
                                    }
                                  },
                                  initialValue: DateTime.now().month.toString(),
                                  validator: (value) {
                                    try {
                                      int.parse(value!);
                                      return null;
                                    } catch (e) {
                                      return "please enter a valid number";
                                    }
                                  }),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .25,
                              margin: const EdgeInsets.all(15),
                              child: TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  decoration: textInputDecoration.copyWith(
                                      fillColor: Colors.transparent,
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 1.5,
                                        ),
                                      ),
                                      hintText: "DD",
                                      hintStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(98, 255, 255, 255),
                                      )),
                                  initialValue: DateTime.now().day.toString(),
                                  onChanged: (value) {
                                    try {
                                      dd = double.parse(value);
                                    } catch (e) {
                                      dd = 0;
                                    }
                                  },
                                  validator: (value) {
                                    try {
                                      int.parse(value!);
                                      return null;
                                    } catch (e) {
                                      return "please enter a valid number";
                                    }
                                  }),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .25,
                              margin: const EdgeInsets.all(15),
                              child: TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  decoration: textInputDecoration.copyWith(
                                      fillColor: Colors.transparent,
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 1.5,
                                        ),
                                      ),
                                      hintText: "YY",
                                      hintStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(98, 255, 255, 255),
                                      )),
                                  initialValue: DateTime.now().year.toString(),
                                  onChanged: (value) {
                                    try {
                                      yy = double.parse(value);
                                    } catch (e) {
                                      yy = 0;
                                    }
                                  },
                                  validator: (value) {
                                    try {
                                      int.parse(value!);
                                      return null;
                                    } catch (e) {
                                      return "please enter a valid number";
                                    }
                                  }),
                            ),
                          ],
                        ),
                        const Text(
                          "Price informations",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .25,
                              margin: const EdgeInsets.all(15),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: textInputDecoration.copyWith(
                                    fillColor: Colors.transparent,
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    hintText: "Unit price",
                                    hintStyle: const TextStyle(
                                      color: Color.fromARGB(98, 255, 255, 255),
                                    )),
                                validator: (value) {
                                  try {
                                    if (value!.isEmpty) {
                                      return "please enter the product unit price value";
                                    } else {
                                      int.parse(value);
                                      return null;
                                    }
                                  } catch (e) {
                                    return "please enter a valid number";
                                  }
                                },
                                onChanged: (value) {
                                  try {
                                    unitPrice = double.parse(value);
                                  } catch (e) {
                                    unitPrice = 0;
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .25,
                              margin: const EdgeInsets.all(15),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: textInputDecoration.copyWith(
                                    fillColor: Colors.transparent,
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    hintText: "Stock price",
                                    hintStyle: const TextStyle(
                                      color: Color.fromARGB(98, 255, 255, 255),
                                    )),
                                validator: (value) {
                                  try {
                                    if (value!.isEmpty) {
                                      return "please enter the product stock price value";
                                    } else {
                                      int.parse(value);
                                      return null;
                                    }
                                  } catch (e) {
                                    return "please enter a valid number";
                                  }
                                },
                                onChanged: (value) {
                                  try {
                                    stockPrice = double.parse(value);
                                  } catch (e) {
                                    stockPrice = 0;
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        const Text(
                          "Descriptive images",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  height: 200,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 217, 217, 217),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                GestureDetector(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  void saveProductInfos(context) {}
}
