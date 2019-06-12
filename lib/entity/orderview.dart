
import 'dart:core';

import 'dart:core';

class OrderView{

  int id;

  double collection_price;

  int order_id;

  String user_id;

  String room_name;

  int pay_status;

  String hotel_name;

  int room_count;

  String order_set_time;

  String room_in_time;

  String room_out_time;

  OrderView.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        room_name = json['room_name'],
        room_count = json['room_count'],
        collection_price = json['collection_price'],
        order_id = json['order_id'],
        pay_status = json['pay_status'],
        room_in_time = json['room_in_time'],
        room_out_time = json['room_out_time'],
        order_set_time = json['order_set_time'],
        hotel_name = json['hotel_name'],
        user_id = json['user_id'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'room_name': room_name,
        'room_count': room_count,
        'collection_price': collection_price,
        'order_id': order_id,
        'pay_status': pay_status,
        'room_out_time': room_out_time,
        'order_set_time': order_set_time,
        'room_in_time': room_in_time,
        'user_id': user_id,
        'hotel_name': hotel_name,

      };

}
