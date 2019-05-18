import 'package:flutter/material.dart';
import '../../widget/MyDivider.dart';

class Orderitem extends StatefulWidget {

  _OrderitemState createState() => _OrderitemState();
}

class _OrderitemState extends State<Orderitem> {


  @override
  Widget build(BuildContext context) {

    final _media = MediaQuery.of(context).size;
    // TODO: implement build
    return InkWell(
      onTap:()=>{

      },
      child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: _media.width / 15,top: 30,bottom: 15),
                    child: Icon(Icons.four_k),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: _media.width / 60,top: 30,bottom: 15),
                    width: _media.width / 1.6,
                    child: Text('莫泰酒店(哈尔滨店)',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _media.width / 20,top: 30,bottom: 15),
                    child: Text('已消费',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey
                      ),
                    ),

                  )
                ],
              ),
              MyDivider(height: 0,indent: _media.width / 15, endindent: _media.width / 15,),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: _media.width / 15,top: 10),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/1.jpg',)
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: _media.width / 40,top: 5),
                          child: Text('1 ' + '间,' + '家庭房',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: _media.width / 40,top: 5),
                          child: Text('01月15日 - 01月19日',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15
                            ),
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: _media.width / 40,top: 5),
                          child: Text(
                            '房价: ' + '\$138.0',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15
                            ),
                          ),
                        )
                      ],
                    )
                    ,
                  )
                ],
              )

            ],
          )
      ),
    );
  }

}

