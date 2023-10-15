// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../api/api_service_client.dart' as _i6;
import '../components/auth/auth_repo.dart' as _i3;
import '../pref/ipreference_helper.dart' as _i5;
import 'app_module.dart' as _i7;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.lazySingleton<_i3.AuthRepository>(() => appModule.provideAuthRepo());
  gh.lazySingleton<_i4.Dio>(() => appModule.provideUserDio());
  await gh.lazySingletonAsync<_i5.IPreferenceHelper>(
    () => appModule.provideDefaultPref(),
    preResolve: true,
  );
  gh.lazySingleton<_i6.ApiServiceClient>(
      () => appModule.providePassClient(gh<_i4.Dio>()));
  return getIt;
}

class _$AppModule extends _i7.AppModule {}
