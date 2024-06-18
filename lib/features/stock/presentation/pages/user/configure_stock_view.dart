import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/core/widgets/loading.dart';
import 'package:yourmanager/core/widgets/screen_separator.dart';
import 'package:yourmanager/features/expenditure/domain/entities/expenditure.dart';
import 'package:yourmanager/features/expenditure/presentation/cubit/expenditure_cubit_manager.dart';
import 'package:yourmanager/features/expenditure/presentation/cubit/expenditure_manager_state.dart';
import 'package:yourmanager/features/expenditure/presentation/pages/stock_expenditures/add_stock_expenditure_view.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/stock_manager_cubit.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/stock_manager_state.dart';

import '../../../../../core/widgets/textinput_decoration.dart';

class ConfigureStockView extends StatefulWidget {
  final String stockId;
  ConfigureStockView({super.key, required this.stockId});

  @override
  State<ConfigureStockView> createState() => _ConfigureStockViewState();
}

class _ConfigureStockViewState extends State<ConfigureStockView> {
  late int dd = 0;

  late int mm = 0;

  late int yy = 0;

  late int stockQuantity = 0;

  late int minStockQuantity = 0;

  late double stockCostPrice = 0;

  late double costPrice = 0;

  late double discount = 0;
  @override
  void initState() {
    super.initState();
    context.read<StockManagerCubit>().getStock(widget.stockId);
    context.read<ExpenditureCubit>().getAllExpenditures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Configure stock",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                context.read<StockManagerCubit>().updateStock(
                      widget.stockId,
                      stockQuantity,
                      minStockQuantity,
                      stockCostPrice,
                      costPrice,
                      discount,
                    );
              },
              child: Container(
                width: 75,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BlocConsumer<StockManagerCubit, StockManagerState>(
          listener: (context, state) {
            if (state is UpdateStockSuccessfully) {
              context
                  .read<StockManagerCubit>()
                  .setConfiguredValue(widget.stockId, true);
              context.read<StockManagerCubit>().getStock(widget.stockId);
            }
          },
          builder: (context, state) {
            return state is IsGettingStock
                ? const LoadingColumn(message: "gettin the stock infos")
                : state is GetStockSuccessfully
                    ? SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SingleChildScrollView(
                              child: Stack(
                            children: [
                              Form(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Expiry date",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .22,
                                          height: 45,
                                          margin: const EdgeInsets.all(15),
                                          child: TextFormField(
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            keyboardType:
                                                TextInputType.datetime,
                                            decoration:
                                                textInputDecoration.copyWith(
                                                    fillColor:
                                                        Colors.transparent,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 1.5,
                                                      ),
                                                    ),
                                                    hintText: "MM",
                                                    hintStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                          98, 255, 255, 255),
                                                    )),
                                            onChanged: (value) {
                                              try {
                                                mm = int.parse(value);
                                              } catch (e) {
                                                mm = 0;
                                              }
                                            },
                                            initialValue:
                                                DateTime.now().month.toString(),
                                            validator: (value) {
                                              try {
                                                int.parse(value!);
                                                return null;
                                              } catch (e) {
                                                return "please enter a valid number";
                                              }
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .22,
                                          height: 45,
                                          margin: const EdgeInsets.all(15),
                                          child: TextFormField(
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              keyboardType:
                                                  TextInputType.datetime,
                                              decoration:
                                                  textInputDecoration.copyWith(
                                                      fillColor:
                                                          Colors.transparent,
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                      hintText: "DD",
                                                      hintStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                            98, 255, 255, 255),
                                                      )),
                                              initialValue:
                                                  DateTime.now().day.toString(),
                                              onChanged: (value) {
                                                try {
                                                  dd = int.parse(value);
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .22,
                                          height: 45,
                                          margin: const EdgeInsets.all(15),
                                          child: TextFormField(
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              keyboardType:
                                                  TextInputType.datetime,
                                              decoration:
                                                  textInputDecoration.copyWith(
                                                      fillColor:
                                                          Colors.transparent,
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                      hintText: "YY",
                                                      hintStyle:
                                                          const TextStyle(
                                                        color: Color.fromARGB(
                                                            98, 255, 255, 255),
                                                      )),
                                              initialValue: DateTime.now()
                                                  .year
                                                  .toString(),
                                              onChanged: (value) {
                                                try {
                                                  yy = int.parse(value);
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    screenSeparator(w: 9),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Pricing and quantity",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    textArea(
                                      state.stock.quantity.toString(),
                                      "Stock quantity",
                                      (value) {
                                        if (value == null) {
                                          return "This field can not be null";
                                        } else {
                                          try {
                                            if (value.isNotEmpty) {
                                              int.parse(value);
                                            }
                                          } catch (e) {
                                            return "The quantity my be an integer value.";
                                          }
                                        }
                                        return null;
                                      },
                                      (value) {
                                        if (value.isNotEmpty) {
                                          stockQuantity = int.parse(value);
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    textArea(state.stock.minQuantity.toString(),
                                        "Min stock quantity", (value) {
                                      if (value == null) {
                                        return "This field can not be null";
                                      } else {
                                        try {
                                          if (value.isNotEmpty) {
                                            int.parse(value);
                                          }
                                        } catch (e) {
                                          return "The min quantity must be an integer value.";
                                        }
                                      }
                                      return null;
                                    }, (value) {
                                      if (value.isNotEmpty) {
                                        minStockQuantity = int.parse(value);
                                      }
                                    }),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    textArea(
                                      state.stock.stockCostPrice.toString(),
                                      "Stock price",
                                      (value) {
                                        if (value == null) {
                                          return "This field can not be null";
                                        } else {
                                          try {
                                            if (value.isNotEmpty) {
                                              double.parse(value);
                                            }
                                          } catch (e) {
                                            return "The Stock price must be a number.";
                                          }
                                        }
                                        return null;
                                      },
                                      (value) {
                                        if (value.isNotEmpty) {
                                          stockCostPrice = double.parse(value);
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    textArea(
                                      state.stock.costPrice.toString(),
                                      "Cost price",
                                      (value) {
                                        if (value == null) {
                                          return "This field can not be null";
                                        } else {
                                          try {
                                            if (value.isNotEmpty) {
                                              double.parse(value);
                                            }
                                          } catch (e) {
                                            return "The cost price must be a number.";
                                          }
                                        }
                                        return null;
                                      },
                                      (value) {
                                        if (value.isNotEmpty) {
                                          costPrice = double.parse(value);
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    textArea(
                                      state.stock.discount.toString(),
                                      "discount",
                                      (value) {
                                        if (value == null) {
                                          return "This field can not be null";
                                        } else {
                                          try {
                                            if (value.isNotEmpty) {
                                              double.parse(value);
                                            }
                                          } catch (e) {
                                            return "The Stock price must be a number.";
                                          }
                                        }
                                        return null;
                                      },
                                      (value) {
                                        if (value.isNotEmpty) {
                                          discount = double.parse(value);
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    screenSeparator(w: 9),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Expenditures of product",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await showDialog(
                                              context: context,
                                              builder: ((context) =>
                                                  AddStockExpenditureView(
                                                    productId: widget.stockId,
                                                  )),
                                            );
                                          },
                                          child: const Text(
                                            "Add expense",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 232, 59),
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    BlocConsumer<ExpenditureCubit,
                                        ExpenditureStateManager>(
                                      listener: (context, state1) {
                                        if (state1
                                            is GetAllExpenditureSuccessfully) {}
                                        if (state1
                                            is GetAllExpenditureFailed) {}
                                      },
                                      builder: (context, state1) {
                                        return state1
                                                is GetAllExpenditureSuccessfully
                                            ? state1.expenditures.isEmpty
                                                ? SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .7,
                                                    child: const Center(
                                                      child: Text(
                                                        "No expenditure register for this product",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Column(
                                                    children: List.of(state1
                                                        .expenditures
                                                        .map((e) {
                                                      if (state
                                                          .stock.expenditures
                                                          .contains(e.id)) {
                                                        return expenditureItem(
                                                            e);
                                                      } else {
                                                        return const SizedBox();
                                                      }
                                                    })),
                                                  )
                                            : SizedBox(
                                                height: 30,
                                                child: Center(
                                                  child: IconButton(
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              ExpenditureCubit>()
                                                          .getAllExpenditures();
                                                    },
                                                    icon: const Icon(
                                                        Icons.replay),
                                                  ),
                                                ),
                                              );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ),
                      )
                    : Center(
                        child: IconButton(
                          onPressed: () {
                            context
                                .read<StockManagerCubit>()
                                .getStock(widget.stockId);
                          },
                          icon: const Icon(Icons.replay),
                        ),
                      );
          },
        ));
  }

  expenditureItem(Expenditure exp) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(5),
      child: ListTile(
        title: Text(
          exp.title,
          style: const TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 38, 118, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(exp.date.toString()),
        trailing: Text(
          '${exp.amount.toString()} MAD',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  textArea(
    String initialValue,
    String labelText,
    validator,
    onChanged,
  ) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: TextInputType.number,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      decoration: textInputDecoration.copyWith(
        fillColor: Colors.transparent,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color.fromARGB(98, 255, 255, 255),
        ),
        suffix: GestureDetector(
          child: const Icon(
            Icons.help,
            color: Colors.white,
          ),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
