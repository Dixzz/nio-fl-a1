import 'package:google_sign_in/google_sign_in.dart';
import 'package:nio_demo/models/user.dart';

abstract class IPreferenceHelper {
  bool isUserLoggedIn();

  Future<void> setUserObject(GoogleSignInAccount user);
  User? getUserObject();

  Future<void> logout();
}

