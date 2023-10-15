// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nio_demo/components/login.dart';
import 'package:nio_demo/components/profile.dart';
import 'package:nio_demo/di/app_module.dart';
import 'package:nio_demo/pref/ipreference_helper.dart';
import 'package:nio_demo/routes/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logout_test.mocks.dart';

@GenerateMocks(<Type>[GoogleSignInPlatform])
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

  /// Open profile page
  /// Click logout
  /// Reset Preferences
  /// Navigate to Login Page
  testWidgets('Profile logout', (WidgetTester tester) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    SharedPreferences.setMockInitialValues({});
    await googleSignIn.signIn();
    await configureDependencies();
    IPreferenceHelper pref = locator.get();
    expect(googleSignIn.currentUser, isNotNull);
    _verifyInit(mockPlatform);
    verify(mockPlatform.signIn());

    pref.setUserObject(googleSignIn.currentUser!);
    expect(true, pref.isUserLoggedIn());

    await tester.pumpWidget(MaterialApp.router(
      routerConfig:
          GoRouter(initialLocation: RouteNames.profile.routeName, routes: [
        GoRoute(
          name: RouteNames.profile.name,
          // Optional, add name to your routes. Allows you navigate by name instead of path
          path: RouteNames.profile.routeName,
          builder: (context, state) {
            return const Profile();
          },
        ),
        GoRoute(
          name: RouteNames.login.name,
          // Optional, add name to your routes. Allows you navigate by name instead of path
          path: RouteNames.login.routeName,
          builder: (context, state) {
            return const Login();
          },
        ),
      ]),
    ));
    expect(find.byType(Profile), findsOneWidget);
    await tester.ensureVisible(find.byType(ElevatedButton).first);
    await tester.tap(find.byType(ElevatedButton).first);
    expect(false, pref.isUserLoggedIn());
    await tester.pumpAndSettle();
    expect(find.byType(Login), findsOneWidget);
  });

  tearDown(() {});
}

void _verifyInit(
  MockGoogleSignInPlatform mockSignIn, {
  List<String> scopes = const <String>[],
  SignInOption signInOption = SignInOption.standard,
  String? hostedDomain,
  String? clientId,
  String? serverClientId,
  bool forceCodeForRefreshToken = false,
}) {
  verify(mockSignIn.initWithParams(argThat(
    isA<SignInInitParameters>()
        .having(
          (SignInInitParameters p) => p.scopes,
          'scopes',
          scopes,
        )
        .having(
          (SignInInitParameters p) => p.signInOption,
          'signInOption',
          signInOption,
        )
        .having(
          (SignInInitParameters p) => p.hostedDomain,
          'hostedDomain',
          hostedDomain,
        )
        .having(
          (SignInInitParameters p) => p.clientId,
          'clientId',
          clientId,
        )
        .having(
          (SignInInitParameters p) => p.serverClientId,
          'serverClientId',
          serverClientId,
        )
        .having(
          (SignInInitParameters p) => p.forceCodeForRefreshToken,
          'forceCodeForRefreshToken',
          forceCodeForRefreshToken,
        ),
  )));
}
