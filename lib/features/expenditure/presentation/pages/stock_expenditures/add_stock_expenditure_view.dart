import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/features/expenditure/presentation/cubit/expenditure_cubit_manager.dart';
import 'package:yourmanager/features/expenditure/presentation/cubit/expenditure_manager_state.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/stock_manager_cubit.dart';

class AddStockExpenditureView extends StatelessWidget {
  final String productId;
  AddStockExpenditureView({super.key, required this.productId});
  late String title = "";
  late double expenditureValue = 0.0;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpenditureCubit, ExpenditureStateManager>(
      listener: (context, state) {
        if (state is ExpenditureRegisteredSuccessfully) {
          context
              .read<StockManagerCubit>()
              .manageExpenditure(productId, state.expenditureId, true)
              .then((value) {
            Navigator.of(context).pop();
          });
        }
      },
      builder: (context, state) {
        return Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              height: 100,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Expenditure",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Expense title",
                        labelStyle: TextStyle(
                            color: Color.fromARGB(220, 255, 255, 255)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field can not be empty.";
                        }
                      },
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Expense Amount",
                          labelStyle: TextStyle(
                            color: Color.fromARGB(220, 255, 255, 255),
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field can not be empty.";
                        } else {
                          try {
                            double.parse(value);
                          } catch (e) {
                            return "The amount value must be a number.";
                          }
                        }
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          try {
                            expenditureValue = double.parse(value);
                          } catch (e) {}
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          print("INSIDDDDDDE");
                          context.read<ExpenditureCubit>().registerExpenditure(
                                title,
                                expenditureValue,
                                DateTime.now(),
                              );
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .7,
                        height: 35,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 226, 195, 19),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            "Register expenditure",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
