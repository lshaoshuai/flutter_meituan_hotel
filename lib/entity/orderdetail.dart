
import 'dart:core';

class OrderDetail{

  double collection_price;

  String user_id;

  String room_name;

  String hotel_name;

  int room_count;

  String room_in_time;

  String room_out_time;

  OrderDetail.fromJson(Map<String, dynamic> json)
      : room_name = json['room_name'],
        room_count = json['room_count'],
        collection_price = json['collection_price'],
        room_in_time = json['room_in_time'],
        room_out_time = json['room_out_time'],
        hotel_name = json['hotel_name'],
        user_id = json['user_id'];

  Map<String, dynamic> toJson() =>
      {
        'room_name': room_name,
        'room_count': room_count,
        'collection_price': collection_price,
        'room_out_time': room_out_time,
        'room_in_time': room_in_time,
        'user_id': user_id,
        'hotel_name': hotel_name,

      };

}
