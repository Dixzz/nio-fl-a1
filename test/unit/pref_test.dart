import 'package:flutter_test/flutter_test.dart';
import 'package:nio_demo/di/app_module.dart';
import 'package:nio_demo/pref/ipreference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late IPreferenceHelper _pref;
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await configureDependencies();
    _pref = locator.get();
  });

  /// always returns false since initial mock is Empty Map
  test('is user logged in', () {
    expect(false, _pref.isUserLoggedIn());
  });

  tearDown(() {});
}
