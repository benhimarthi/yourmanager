import 'package:flutter/material.dart';

Widget productInventoryItem({
  String name = "product_name product name ",
  String productDesc = "Product description...",
  int quantity = 6,
  int minQuantity = 3,
  context,
}) {
  return Container(
    margin: const EdgeInsets.all(4),
    width: MediaQuery.of(context).size.width * 9,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color.fromARGB(255, 237, 237, 237),
    ),
    child: Column(
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      child: GestureDetector(
                        child: Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 217, 217, 217),
                            borderRadius: BorderRadius.circular(27),
                            border: Border.all(width: 3, color: Colors.white),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.inventory,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      //color: Colors.amber,
                      width: MediaQuery.of(context).size.width * .3,
                      child: Text(
                        name,
                        style: TextStyle(
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'x$quantity',
                    style: TextStyle(
                        fontSize: 12,
                        color: quantity <= minQuantity
                            ? Colors.red
                            : Colors.green),
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

Widget productInfoSection({
  dynamic value,
  String label = 'Piece number',
  nLine = false,
  context,
}) {
  return SizedBox(
    width: nLine
        ? MediaQuery.of(context).size.width * .35
        : MediaQuery.of(context).size.width * .5,
    child: nLine
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .25,
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                    child: Text(
                      ':',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .35,
                child: Text(
                  value.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5,
                    child: Text(
                      ':',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .2,
                    child: Text(
                      value.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
  );
}

/*InternationalPhoneNumberInput(
                      textStyle: const TextStyle(color: textColor1),
                      onInputChanged: (PhoneNumber number) {
                        // Do something with the entered phone number.
                      },
                      inputDecoration: textInputDecoration.copyWith(
                        focusColor: onFocusTextFieldBorderColor,
                        hintText: "Phone number",
                        hintStyle: const TextStyle(
                            color: onUnFocusTextFieldBorderColor),
                      ),
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      validator: (nb) {
                        String phoneNb = nb!.trim();
                        if (isValidPhoneNumber(phoneNb)) {
                          return "Invalid phone number: $phoneNb";
                        } else {
                          return null;
                        }
                      },
                    ),*/