import 'package:flutter/material.dart';
import 'package:nio_demo/components/auth/auth_repo.dart';
import 'package:nio_demo/di/app_module.dart';
import 'package:nio_demo/gen/assets.gen.dart';
import 'package:nio_demo/routes/router.dart';
import 'package:nio_demo/tools/asset_image_gen.dart';
import 'package:nio_demo/tools/cards.dart';
import 'package:nio_demo/tools/sized_box.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  AuthRepository get _authRepository => locator.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2022),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SpaceVertical(100),
              SizedBox.square(dimension: 250, child: Assets.images.loginLogo.toImage(),),
              SpaceVertical(40),
              Text(
                'Sign in with',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              const SpaceVertical(24),
              InkWell(
                onTap: () async {
                  if (await _authRepository.handleAuth(context) && context.mounted) {
                    RouteNames.home.navigate(context);
                  }
                },
                // onTap: () => _handleSignIn(context),
                child: RoundedCard(
                    child: ConstrainedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 80.0),
                          child: Wrap(
                            runAlignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Assets.images.icGoogle.svg(width: 50),
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Text('Google'),
                              ),
                            ],
                          ),
                        ),
                        constraints: BoxConstraints(
                            minHeight: 75, minWidth: double.infinity))),
              ),
              const SpaceVertical(16),
              RoundedCard(
                  color: Color(0xFF3D6AD6),
                  child: ConstrainedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Wrap(
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Assets.images.icFacebook.svg(width: 50),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Text(
                                'Facebook',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      constraints: BoxConstraints(
                          minHeight: 75, minWidth: double.infinity))),
              const SpaceVertical(16),
              RoundedCard(
                  color: Color(0xFF0077B5),
                  child: ConstrainedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Wrap(
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Assets.images.icLinkedin.svg(width: 50),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Text(
                                'LinkedIn',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      constraints: BoxConstraints(
                          minHeight: 75, minWidth: double.infinity))),
              const SpaceVertical(16),
              // ElevatedButton.icon(
              //     icon: Assets.images.icLinkedin.svg(width: 50),
              //     onPressed: () {
              //       _handleSignIn(context);
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Color(0xFF0077B5),
              //     ),
              //     label: Text('LinkedIn')),
            ],
          ),
        ),
      ),
    );
  }
}
