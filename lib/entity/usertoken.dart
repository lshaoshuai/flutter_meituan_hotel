
class UserToken{

  String phone_num;

  String acesstoken;

  UserToken.fromJson(Map<String, dynamic> json)
      :phone_num = json['phone_num'],
        acesstoken = json['acesstoken'];


  Map<String, dynamic> toJson() =>
      {

        'phone_num': phone_num,
        'acesstoken': acesstoken

      };
}