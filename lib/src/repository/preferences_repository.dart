
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {

  updateLocale(String locale) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('locale', locale);
  }
}