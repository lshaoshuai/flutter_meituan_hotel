
class RoomView{

  int id;

  int room_count;

  String room_name;

  double room_price;

  String room_detail;

  String room_pic;

  bool _cancel;

  RoomView.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        room_name = json['room_name'],
        room_count = json['room_count'],
        room_price = json['room_price'],
        room_detail = json['room_detail'],
        room_pic = json['room_pic'],
        _cancel = json['_cancel'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'room_name': room_name,
        'room_count': room_count,
        'room_price': room_price,
        'room_detail': room_detail,
        'room_pic': room_pic,
        '_cancel': _cancel,

      };
}