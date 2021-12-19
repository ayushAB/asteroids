import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef void DateSelected(String date);

class DatePicker extends StatefulWidget {
  DatePicker(
      {Key? key,
      this.restorationId,
      required this.onDateSelected,
      required this.titleText})
      : super(key: key);
  final String? restorationId;
  final DateSelected onDateSelected;
  final titleText;
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;
  String selectedDate = DateFormat('yyyy-MM-dd').format(new DateTime.now());

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021, 1, 1),
          lastDate: DateTime(2022, 1, 1),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(newSelectedDate);
        widget.onDateSelected(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 5.0,
        bottom: 5.0,
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.titleText,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                selectedDate,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.date_range),
              onPressed: () {
                _restorableDatePickerRouteFuture.present();
              },
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Color(0xFFE6734F),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
