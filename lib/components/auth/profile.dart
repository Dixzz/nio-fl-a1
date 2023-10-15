import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nio_demo/components/auth/auth_repo.dart';
import 'package:nio_demo/di/app_module.dart';
import 'package:nio_demo/pref/ipreference_helper.dart';
import 'package:nio_demo/tools/context.dart';
import 'package:nio_demo/tools/sized_box.dart';
import 'package:nio_demo/widgets/appbar_action.dart';
import 'package:nio_demo/widgets/symmetric_loader.dart';

import '../../routes/router.dart';

class Profile extends StatelessWidget {
  IPreferenceHelper get pref => locator.get();

  AuthRepository get _authRepository => locator.get();

  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
                height: 300,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(12)),
                      color: Color(0xFF1E2022)),
                )),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppbarAction(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                  onTap: () {
                    context.goRouter.pop();
                  },
                ),
                SpaceVertical(90),
                Builder(builder: (_) {
                  final user = pref.getUserObject();
                  if (user == null) return SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: user.url != null
                              ? CachedNetworkImage(
                                  imageUrl: user.url!,
                                  fit: BoxFit.fill,
                                  placeholderFadeInDuration:
                                      const Duration(seconds: 1),
                                  placeholder: (_, __) => const Center(
                                      child: SizedBox.square(
                                    dimension: 20,
                                    child:
                                        SymmetricSizeBoxedProgressIndicator(),
                                  )),
                                )
                              : ColoredBox(
                                  color: Colors.grey.shade200,
                                  child: Icon(
                                    Icons.person,
                                    size: 100,
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SpaceVertical(40),
                            Text(
                              'Name',
                              style: TextStyle(
                                color: Color(0xFFABABAB),
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SpaceVertical(6),
                            IgnorePointer(
                              child: TextFormField(
                                initialValue: user.name,
                                readOnly: true,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: .8),
                                decoration: InputDecoration(
                                  // isDense: true,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  focusedBorder: InputBorder.none,
                                  fillColor: Color(0xFFEEEEEE),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            SpaceVertical(20),
                            const Text(
                              'Email Id',
                              style: TextStyle(color: Color(0xFFABABAB)),
                              textAlign: TextAlign.start,
                            ),
                            SpaceVertical(9),
                            IgnorePointer(
                              child: TextFormField(
                                initialValue: user.email,
                                readOnly: true,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: .8),
                                decoration: InputDecoration(
                                  // isDense: true,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  focusedBorder: InputBorder.none,
                                  fillColor: Color(0xFFEEEEEE),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            SpaceVertical(70),
                            ElevatedButton(
                              onPressed: () async {
                                if (await _authRepository.logout() &&
                                    context.mounted) {
                                  RouteNames.login.navigate(context);
                                }
                              },
                              child: Text("Logout"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFF0F00),
                              ),
                            ),
                            SpaceVertical(20),
                          ],
                        ),
                      )
                    ],
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
