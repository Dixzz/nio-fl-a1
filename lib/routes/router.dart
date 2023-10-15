// GoRouter configuration
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:nio_demo/components/auth/login.dart';
import 'package:nio_demo/components/auth/profile.dart';
import 'package:nio_demo/components/home/beer_detail.dart';
import 'package:nio_demo/components/home/home.dart';
import 'package:nio_demo/di/app_module.dart';
import 'package:nio_demo/pref/ipreference_helper.dart';
import 'package:nio_demo/tools/context.dart';
import 'package:nio_demo/tools/logger.dart';

enum RouteNames {
  login,
  home,
  beerDetail,
  profile,
  ;

  String get routeName {
    return "/$name";
  }

  Future navigate(BuildContext context, [dynamic arguments]) async {
    context.goRouter.pushNamed(name, extra: arguments);
  }
}

class _GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logit('didPush: $route');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logit('didPop: $route');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logit('didRemove: $route');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    logit('logitdidReplace: $newRoute');
  }
}

class RouteConfig {
  static final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: RouteNames.home.routeName,
    observers: [_GoRouterObserver()],
    redirect: (BuildContext context, GoRouterState state) {
      final IPreferenceHelper pref = locator.get();
      if (!pref.isUserLoggedIn()) {
        return RouteNames.login.routeName;
      } else {
        return null;
      }
    },
    routes: [
      GoRoute(
        name: RouteNames.profile.name,
        // Optional, add name to your routes. Allows you navigate by name instead of path
        path: RouteNames.profile.routeName,
        builder: (context, state) {
          return const Profile();
        },
      ),
      GoRoute(
        name: RouteNames.home.name,
        // Optional, add name to your routes. Allows you navigate by name instead of path
        path: RouteNames.home.routeName,
        builder: (context, state) => Home(
          client: locator.get(),
        ),
      ),
      GoRoute(
        name: RouteNames.beerDetail.name,
        // Optional, add name to your routes. Allows you navigate by name instead of path
        path: RouteNames.beerDetail.routeName,
        builder: (context, state) => BeerDetail(state.extra as int, locator.get()),
      ),
      GoRoute(
        name: RouteNames.login.name,
        path: RouteNames.login.routeName,
        builder: (context, state) => const Login(),
      ),
    ],
  );
}
