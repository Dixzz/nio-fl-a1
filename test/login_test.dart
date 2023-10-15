// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:mockito/mockito.dart';
import 'package:nio_demo/components/login.dart';
import 'package:nio_demo/di/app_module.dart';
import 'package:nio_demo/main.dart';
import 'package:nio_demo/pref/ipreference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logout_test.mocks.dart';


class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  late MockGoogleSignInPlatform mockPlatform;
  final GoogleSignInUserData kDefaultUser = GoogleSignInUserData(
      email: 'john.doe@gmail.com',
      id: '8162538176523816253123',
      photoUrl: 'https://lh5.googleusercontent.com/photo.jpg',
      displayName: 'John Doe',
      serverAuthCode: '789');

  setUp(() {
    // HttpOverrides.global = _HttpOverrides();
    mockPlatform = MockGoogleSignInPlatform();
    when(mockPlatform.isMock).thenReturn(true);
    when(mockPlatform.userDataEvents).thenReturn(null);
    when(mockPlatform.signInSilently())
        .thenAnswer((Invocation _) async => kDefaultUser);
    when(mockPlatform.signIn())
        .thenAnswer((Invocation _) async => kDefaultUser);

    GoogleSignInPlatform.instance = mockPlatform;
  });

  /// Open Login Page
  /// Clicks on `Google` button
  /// Check if google login success
  testWidgets('Login and check user logged', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await configureDependencies();

    await tester.pumpWidget(const MyApp());
    expect(find.byType(Login), findsOneWidget);
    expect(find.text('Sign in with'), findsOneWidget);
    expect(find.byType(InkWell).first, findsOneWidget);
    await tester.tap(find.byType(InkWell).first);
    IPreferenceHelper pref = locator.get();
    expect(true, pref.isUserLoggedIn());
    // await tester.pump();
    // await tester.pumpAndSettle();

    return;
    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  tearDown(() {});
}
