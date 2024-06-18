import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  late List<String> options;
  late String selectedOption;
  final BoxDecoration? buttonBoxDecoration;
  final double h;
  final double w;
  CustomBottomSheet({
    super.key,
    required this.options,
    required this.h,
    required this.w,
    this.buttonBoxDecoration,
    this.selectedOption = "",
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  late String currentOption;
  @override
  void initState() {
    super.initState();
    currentOption =
        widget.options.isNotEmpty ? widget.options[0] : "Select a category";
    widget.selectedOption = currentOption;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 200,
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    widget.options.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          currentOption = widget.options[index];
                          widget.selectedOption = currentOption;
                          Navigator.pop(context);
                        });
                      },
                      child: ListTile(
                        title: Text(
                          widget.options[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: widget.w,
        height: widget.h,
        decoration: widget.buttonBoxDecoration,
        child: Center(
          child: Text(
            currentOption,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
