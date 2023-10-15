import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:nio_demo/models/user.dart';
import 'package:nio_demo/pref/ipreference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IPreferenceHelperImpl implements IPreferenceHelper {
  final SharedPreferences _preferences;

  IPreferenceHelperImpl(this._preferences);

  @override
  bool isUserLoggedIn() {
    return getUserObject() != null;
  }

  @override
  User? getUserObject() {
    final s = _preferences.getString(_PrefConst.userExist.name);
    if (s == null || s.isEmpty) return null;
    return User.fromJson(jsonDecode(s));
  }

  @override
  Future<void> setUserObject(GoogleSignInAccount user) {
    // todo: move to encry

    return _preferences.setString(_PrefConst.userExist.name,
        jsonEncode(User(user.displayName, user.email, user.photoUrl)));
  }

  @override
  Future<void> logout() async {
    await _preferences.clear();
    await GoogleSignIn().signOut();
  }
}

enum _PrefConst {
  userExist,
  ;
}
