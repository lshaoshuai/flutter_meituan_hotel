
class HotelView{

  int id;

  String hotel_name;

  String hotel_location;

  String hotel_pic;

  String hotel_grade;

  String neighbor_location;

  String tap;

  String commuser_num;

  HotelView();

  HotelView.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        hotel_name = json['hotel_name'],
        hotel_location = json['hotel_location'],
        hotel_pic = json['hotel_pic'],
        hotel_grade = json['hotel_grade'],
        neighbor_location = json['neighbor_location'],
        tap = json['tap'],
        commuser_num = json['commuser_num'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'hotel_name': hotel_name,
        'hotel_location': hotel_location,
        'hotel_pic': hotel_pic,
        'hotel_grade': hotel_grade,
        'neighbor_location': neighbor_location,
        'tap': tap,
        'commuser_num': commuser_num,

      };
}