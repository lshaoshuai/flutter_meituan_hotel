
import 'package:shared_preferences/shared_preferences.dart';

Future saveStorageString(key,value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString(
      key, value);
}


