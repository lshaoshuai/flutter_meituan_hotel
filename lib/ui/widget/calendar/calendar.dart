import 'package:flutter/material.dart';
import 'timeutil.dart';
import 'daygridview.dart';

class Calendar extends StatefulWidget {
  DateTime initTime;
  DateTime firstTime;
  DateTime endTime;
  ValueChanged onChange;

  Calendar({
    Key key,
    this.initTime,
    this.firstTime,
    this.endTime,
    this.onChange,
  }) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  DateTime selectDate;

  @override
  void initState() {
    super.initState();
    print(widget.firstTime.month);
    selectDate = widget.initTime;
  }

  onChange(time) {
    if (selectDate != time) {
      setState(() {
        selectDate = time;
        widget.onChange(time);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: 300,
        child:  DayGridView(
              initDate: DateTime(widget.initTime.year, widget.initTime.month, widget.initTime.day),
              selectDate: DateTime(selectDate.year, selectDate.month, selectDate.day),
              year: widget.firstTime.year + ((widget.firstTime.month) / 12).floor(),
              month: (widget.firstTime.month) % 12 == 0 ? 12 : (widget.firstTime.month) % 12,
              onChange: onChange,
            )
      );
  }
}

class CalendarController extends ValueNotifier<CalendarselectValue> {
  CalendarController() :super(new CalendarselectValue());
}

class CalendarselectValue {
  DateTime selectdate;
}
