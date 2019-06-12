import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'timeutil.dart';

class DayGridView extends StatefulWidget {
  DateTime initDate;
  DateTime selectDate;
  DateTime secselectDate;
  int monthtime;
  int year;
  int month;
  ValueChanged onChange;
  ScrollController controller;

  DayGridView({
    Key key,
    @required this.initDate,
    @required this.selectDate,
    @required this.secselectDate,
    @required this.year,
    @required this.month,
    @required this.monthtime,
    @required this.controller,
    this.onChange,
  });

  @override
  State<DayGridView> createState() => _DayGridViewState();
}

class _DayGridViewState extends State<DayGridView> {

  Color selectcolor = Colors.redAccent.withAlpha(50);
  Color selecttextcolor = Colors.black.withAlpha(200);

  @override
  void initState() {
    super.initState();
  }

  List<Widget> dayItems() {
    int year = widget.year;
    int month = widget.month;
    List days =[];
    for(int i =0;i< widget.monthtime;i++){
      if(month + i == 11){
        year+=1;
      }
      days.addAll(TimeUtil.getDay(year, month + i, MaterialLocalizations.of(context)));
    }
    List dayWidgets = days.map((value) {
      if (value is int) {
        return Container();
      }
      if (value == widget.selectDate || value == widget.secselectDate) {
        return GestureDetector(
          onTap: () {
            widget.onChange({0:widget.selectDate});
          },
          child: Container(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: value == widget.selectDate ? BorderRadius.only(topLeft: Radius.circular(5),bottomLeft:Radius.circular(5)):BorderRadius.only(topRight: Radius.circular(5),bottomRight:Radius.circular(5)),
              ),
              child: Text(
                value.day.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                ),
              ),
            ),
          ),
        );
      } else {
        if (value == widget.initDate) {
          return GestureDetector(
            onTap: () {
              if(widget.selectDate != widget.secselectDate)
              {
                widget.onChange({0:value});
              }else{
                widget.onChange({1:value});
              }
            },
            child: Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Text(
                  value.day.toString(),
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18
                  ),
                )
            ),
          );
        }else if(widget.selectDate.isBefore(value) && widget.secselectDate.isAfter(value) ) {

          return GestureDetector(
            onTap: () {
              if(widget.selectDate != widget.secselectDate)
              {
                widget.onChange({0:value});
              }else{
                widget.onChange({1:value});
              }
            },
            child: Container(
                color: selectcolor,
                alignment: Alignment.center,
                child: Container(
                  child: Text(
                    value.day.toString(),
                    style: TextStyle(
                        color: selecttextcolor,
                        fontSize: 18
                    ),
                  ),
                )),
          );

        } else if(widget.initDate.isAfter(value)){
          return Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                value.day.toString(),
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18
                ),
              )
          );

        } else {
          return GestureDetector(
            onTap: () {
              if(widget.selectDate != widget.secselectDate)
              {
                widget.onChange({0:value});
              }else{
                widget.onChange({1:value});
              }
            },
            child: Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Container(
                  child: Text(
                    value.day.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                    ),
                  ),
                )),
          );
        }
      }
    }).toList();
    return dayWidgets;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = dayItems();
    return Container(
      height: 360.0  * widget.monthtime + 60,
      child: GridView.custom(
          controller: widget.controller,
          gridDelegate:  _DayPickerGridDelegate(mainAxisNumber: list.length > 35 ? 6 : 5),
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(5),
          childrenDelegate:
          SliverChildListDelegate(list, addRepaintBoundaries: false)),
    );
  }
}

/// 自定义GridView
class _DayPickerGridDelegate extends SliverGridDelegate {
  final int mainAxisNumber;

  const _DayPickerGridDelegate({
    this.mainAxisNumber,
  });

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    const int columnCount = DateTime.daysPerWeek;
    final double tileWidth = constraints.crossAxisExtent / columnCount;
    final double tileHeight = 400 / mainAxisNumber;
    return SliverGridRegularTileLayout(
      crossAxisCount: columnCount,
      mainAxisStride: tileHeight,
      crossAxisStride: tileWidth,
      childMainAxisExtent: tileHeight,
      childCrossAxisExtent: tileWidth,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_DayPickerGridDelegate oldDelegate) => false;
}

const _DayPickerGridDelegate _kDayPickerGridDelegate = _DayPickerGridDelegate();
