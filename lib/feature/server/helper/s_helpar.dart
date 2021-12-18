
import 'package:shared_preferences/shared_preferences.dart';

class SHelper {
  SHelper._();
  static SHelper sHelper = SHelper._();

  SharedPreferences sharedPreferences;

  Future<SharedPreferences> initSharedPrefrences() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences;
    } else {
      return sharedPreferences;
    }
  }

  addNew(String key, String value) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setString(key, value);
  }

  Future<String> getValue(String key) async {
    sharedPreferences = await initSharedPrefrences();
    String x = sharedPreferences.getString(key);
    return x; 
    
  }
  clearSp() async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.clear();
  }

  setCountNotification(int value) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setInt('countNotifi', value);
  }

  Future<int> getCountNotification() async {
    sharedPreferences = await initSharedPrefrences();
    int x = sharedPreferences.getInt('countNotifi');
    return x;
  }
  
}
