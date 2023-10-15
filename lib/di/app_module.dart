import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nio_demo/api/api_service_client.dart';
import 'package:nio_demo/api/url.dart';
import 'package:nio_demo/di/app_module.config.dart';
import 'package:nio_demo/pref/ipreference_helper.dart';
import 'package:nio_demo/pref/ipreference_helper_impl.dart';
import 'package:nio_demo/tools/logging_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
configureDependencies() => $initGetIt(locator);

@module
abstract class AppModule {
  @lazySingleton
  Dio provideUserDio() {
    final dio = Dio(BaseOptions()
      ..sendTimeout = const Duration(seconds: 5)
      ..connectTimeout = const Duration(seconds: 120)
      ..receiveTimeout = const Duration(seconds: 120));

    dio.options.baseUrl = UrlConstants.baseUrl;

    final dioInterceptor = dio.interceptors;
    if (kDebugMode) {
      dioInterceptor.add(LoggingPathInterceptor());
    }
    // dioInterceptor.add(CommonResponseInterceptor());
    return dio;
  }

  @lazySingleton
  ApiServiceClient providePassClient(final Dio dio) {
    return ApiServiceClient(dio);
  }

  @lazySingleton
  @preResolve
  Future<IPreferenceHelper> provideDefaultPref() async {
    return IPreferenceHelperImpl(await SharedPreferences.getInstance());
  }
}
