import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel/common/api.dart';
import 'package:hotel/common/constant.dart';
import 'package:hotel/entity/hotelview.dart';
import 'package:hotel/http/service/NetService.dart';
import 'package:hotel/ui/widget/MyDivider.dart';
import 'package:hotel/ui/widget/progress/CustomProgressIndicator.dart';
import 'package:hotel/ui/widget/progress/progressdialog.dart';
import 'hotel_item.dart';

class HotelPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HotelState();
  }
}

class _HotelState extends State<HotelPage>{

  List<HotelView> hotel_list = [];
  List<String> titlelist = ["酒店品牌","酒店品牌","酒店品牌","酒店品牌","酒店品牌"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedFruit;
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetService.post(HOTEL_URL, (response){
      print(response.data['result']);
      setState(() {
        _loading = false;
        hotel_list.add(new HotelView.fromJson(response.data['result']));
        print(new HotelView.fromJson(response.data['result']).hotel_name);
      });
    },errorCallBack: (errorMsg){
      print(errorMsg);
      setState(() {
        _loading = false;
      });
      Fluttertoast.showToast(
          msg: "网络请求异常，获取不到酒店信息",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white70,
          fontSize: 16.0
      );
    });
    _dropDownMenuItems = buildAndGetDropDownMenuItems(titlelist);
    _selectedFruit = _dropDownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {

    PageController pageController = PageController(initialPage: 2,viewportFraction: 0.20);
    final _media = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: ()=>Navigator.pop(context),
            ),
            elevation: 0.5,
            backgroundColor: Colors.white,
            bottom: PreferredSize(
                child:Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: <Widget>[
                          _appbartitle("位置区域"),
                          _appbartitle("价格星级"),
                          _appbartitle("智能排序"),
                          _appbartitle("筛选")
                        ],
                      ),
                    ),
                    Container(
                        height: 25,
                        width: _media.width,
                        margin: EdgeInsets.only(bottom: 10,top: 10),
                        child:  PageView.builder(
                            controller: pageController,
                            itemCount: titlelist.length,
                            itemBuilder: (BuildContext context, int index){
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                child: new DropdownButton(

                                    items:  _dropDownMenuItems,
                                    onChanged: changedDropDownItem,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withAlpha(50),
                                    borderRadius: BorderRadius.circular(4.0)
                                ),
                              );
                            }
                        )
                    ),

                  ],
                ) ,
                preferredSize: Size.fromHeight(60)
            )
        ),
        body: ProgressDialog(
          loading: _loading,
          progress: CustomProgressIndicator.HeartBeat(_media),
          child:_mainbody(),
        )
    );
  }

  _appbartitle(String text){

    return Container(
      margin: EdgeInsets.only(left: 30),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: fontname
        ),
      ),
    );
  }

  _mainbody(){

    return Container(
      child: ListView.builder(
          itemCount: hotel_list.length,
          itemBuilder: (BuildContext context,int index){
            return HotelItem(hotelView: hotel_list[index],);
          }
      ),
    );
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = List();
    for (String fruit in fruits) {
      items.add(DropdownMenuItem(value: fruit, child: Text(fruit)));
    }
    return items;
  }

  void changedDropDownItem(String selectedFruit) {
    setState(() {
      _selectedFruit = selectedFruit;
    });
  }


}