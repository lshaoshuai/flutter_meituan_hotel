import 'package:flutter/material.dart';
import 'package:hotel/common/constant.dart';
import '../MyDivider.dart';
import 'timeutil.dart';
import 'daygridview.dart';

class Calendar extends StatefulWidget {
  DateTime initTime;
  DateTime firstTime;
  DateTime endTime;
  ValueChanged onChange;
  ScrollController controller;

  Calendar({
    Key key,
    this.initTime,
    this.firstTime,
    this.endTime,
    this.onChange,
    this.controller
  }) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {


  bool is_selectsec = true;

  @override
  void initState() {
    super.initState();
//    selectDate = widget.initTime;
//    secselectDate = widget.initTime.add(Duration(days: 1));
  }

  onChange(time) {
    if (time.containsKey(1)) {
      if (secselectDate != time[1]) {
        setState(() {
          if(secselectDate.isAfter(time[1]))
          {
            selectDate = time[1];
          }
          secselectDate = time[1];
          widget.onChange([selectDate,secselectDate]);
        });
      }
    } else {
      if (selectDate != time[0]) {
        setState(() {
          selectDate = time[0];
          secselectDate = selectDate;
          //widget.onChange(time);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Container(
        child:
        DayGridView(
          controller: widget.controller,
          initDate: DateTime(widget.initTime.year, widget.initTime.month, widget.initTime.day),
          monthtime: 3,
          selectDate: DateTime(selectDate.year, selectDate.month, selectDate.day),
          secselectDate: DateTime(secselectDate.year, secselectDate.month, secselectDate.day),
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
