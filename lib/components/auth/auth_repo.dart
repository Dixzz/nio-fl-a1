import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nio_demo/di/app_module.dart';
import 'package:nio_demo/pref/ipreference_helper.dart';

class AuthRepository {

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  IPreferenceHelper get _pref => locator.get();

  Future<bool> _handleSignIn(BuildContext context) async {
    final user = _googleSignIn.currentUser;
    if (user == null) {
      return _setUser(await _googleSignIn.signIn(), context);
      // try {
      //   _setUser(await googleSignIn.signIn(), context);
      // } catch (error) {
      //   logit(error);
      // }
    } else {
      return _setUser(user, context);
    }
  }

  bool _setUser(GoogleSignInAccount? user, BuildContext context) {
    if (user == null || !context.mounted) return false;
    _pref.setUserObject(user);
    return true;
  }

  Future<bool> handleAuth(final BuildContext context) async {
    return await _handleSignIn(context);
  }

  Future<bool> logout() async {
    await _pref.logout();
    await _googleSignIn.signOut();
    return true;
  }
}
