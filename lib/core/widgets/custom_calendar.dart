import 'package:flutter/material.dart';
import 'package:yourmanager/core/util/change_screen_mang.dart';
import 'package:yourmanager/core/widgets/small_text_format.dart';
import 'package:yourmanager/features/balance_sheet/presentation/pages/blanace_sheet_page.dart';

import '../util/int_2_month.dart';

class CustomCalandar extends StatefulWidget {
  const CustomCalandar({super.key});
  @override
  State<CustomCalandar> createState() => _CustomCalandarState();
}

class _CustomCalandarState extends State<CustomCalandar> {
  int day = -1;
  List<int> daysInMoth = [];
  final date = DateTime.now();
  late int month;
  late int year;
  final int maxMonth = 12;
  final int minMonth = 1;

  @override
  void initState() {
    super.initState();
    month = date.month;
    year = date.year;
    day = -1;
    for (var n = 1; n < getDaysInMonth(year, month) + 2; n++) {
      daysInMoth.add(n);
    }
  }

  void cutInitialisation() {
    daysInMoth.clear();
    day = -1;
    for (var n = 1; n < getDaysInMonth(year, month) + 2; n++) {
      daysInMoth.add(n);
    }
  }

  int getDaysInMonth(int year, int month) {
    // Create a DateTime object for the first day of the next month
    DateTime firstDayOfNextMonth = DateTime(year, month + 1, 1);

    // Subtract one day from the first day of the next month to get the last day of the current month
    DateTime lastDayOfThisMonth =
        firstDayOfNextMonth.subtract(const Duration(days: 1));

    // Extract the day component to get the number of days in the month
    return lastDayOfThisMonth.day;
  }

  int getWeekOrderInYear(DateTime date) {
    // Get the beginning of the year
    DateTime beginningOfYear = DateTime(date.year, 1, 1);

    // Calculate the difference in days between the date and the beginning of the year
    int differenceInDays = date.difference(beginningOfYear).inDays;

    // Calculate the week number by dividing the difference in days by 7 and rounding up
    int weekNumber = (differenceInDays / 7).ceil();

    return weekNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (month >= minMonth) {
                        month -= 1;
                        day = -1;
                        cutInitialisation();
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 24,
                    color: Colors.white,
                  )),
              SmallText(
                content: toMonth(month),
                fontSize: 16,
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (month <= maxMonth) {
                        month += 1;
                        day = -1;
                        cutInitialisation();
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 24,
                    color: Colors.white,
                  ))
            ]),
        header(),
        firstLine(),
        regularLine(),
        regularLine(),
        regularLine(),
        regularLine(),
        regularLine(),
      ],
    );
  }

  Row header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SmallText(content: month.toString()),
        const SmallText(content: 'Su'),
        const SmallText(content: 'Mo'),
        const SmallText(content: 'Tu'),
        const SmallText(content: 'We'),
        const SmallText(content: 'Th'),
        const SmallText(content: 'Fr'),
        const SmallText(content: 'Sa'),
      ],
    );
  }

  Row firstLine() {
    final fdate = DateTime(year, month, 1);
    int weekDay = fdate.weekday;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(8, (index) {
        if (index - 1 >= weekDay && day < daysInMoth.length - 1) {
          day += 1;
        }
        return index - 1 >= weekDay
            ? repr(
                daysInMoth[day].toString(),
                daysInMoth[day] == DateTime.now().day &&
                    DateTime.now().month == month &&
                    DateTime.now().month == month)
            : index == 0
                ? Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    width: 40,
                    height: 40,
                    child: Center(
                      child: SmallText(
                          content: getWeekOrderInYear(
                                  DateTime(year, month, daysInMoth[0]))
                              .toString()),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    width: 40,
                    height: 40,
                  );
      }),
    );
  }

  Row lastLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(8, (index) {
        if (index >= 0) {
          day += 1;
        }
        return index >= 1 && day <= daysInMoth.length
            ? repr(
                daysInMoth[day - 1].toString(),
                daysInMoth[day - 1] == DateTime.now().day &&
                    DateTime.now().month == month)
            : index == 0
                ? Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    width: 40,
                    height: 40,
                    child: Center(
                      child: SmallText(
                          content: getWeekOrderInYear(
                                  DateTime(year, month, daysInMoth[day]))
                              .toString()),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    width: 40,
                    height: 40,
                  );
      }),
    );
  }

  Row regularLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(8, (index) {
        if (index >= 1 && day < daysInMoth.length - 1) {
          day += 1;
        }
        return day < daysInMoth.length - 1 && index > 0
            ? repr(
                daysInMoth[day].toString(),
                daysInMoth[day] == DateTime.now().day &&
                    DateTime.now().month == month)
            : index == 0
                ? Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    width: 40,
                    height: 40,
                    child: Center(
                      child: SmallText(
                          content: getWeekOrderInYear(
                                  DateTime(year, month, daysInMoth[day]))
                              .toString()),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    width: 40,
                    height: 40,
                  );
      }),
    );
  }

  Widget repr(String day, bool isToday) {
    return !isToday
        ? GestureDetector(
            onTap: () {
              nextScreen(context, BalanceSheetPage());
            },
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                  child: SmallText(
                content: day,
                color: Theme.of(context).primaryColor,
              )),
            ),
          )
        : GestureDetector(
            onTap: () {
              nextScreen(context, BalanceSheetPage());
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: SmallText(
                    content: day,
                    color: Theme.of(context).primaryColor,
                  )),
                )
              ],
            ),
          );
  }
}
