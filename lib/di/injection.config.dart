// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:event_bus/event_bus.dart' as _i4;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/data/datasource/api/flight_api.dart' as _i5;
import '../core/data/datasource/api/user_api.dart' as _i11;
import '../core/utils/media_service.dart' as _i8;
import '../core/utils/permission_service.dart' as _i9;
import '../core/utils/refresh_token_interceptor.dart' as _i10;
import '../ui/cubit/flight_cubit.dart' as _i6;
import 'app_modules.dart' as _i13;
import 'network_modules.dart' as _i12;

const String _dev = 'dev';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final networkModule = _$NetworkModule();
  final appModule = _$AppModule();
  gh.factory<_i3.Dio>(
    () => networkModule.client,
    registerFor: {_dev},
  );
  gh.singleton<_i4.EventBus>(appModule.eventBus);
  gh.factory<_i5.FLightApi>(() => _i5.FLightApi(get<_i3.Dio>()));
  gh.factory<_i6.FlightCubit>(() => _i6.FlightCubit(get<_i5.FLightApi>()));
  gh.singleton<_i7.FlutterSecureStorage>(appModule.storage);
  gh.factory<_i8.MediaService>(() => _i8.MediaServiceImpl());
  gh.factory<_i9.PermissionService>(() => _i9.PermissionServiceHandler());
  gh.factory<_i10.RefreshTokenInterceptor>(
      () => _i10.RefreshTokenInterceptor(get<_i7.FlutterSecureStorage>()));
  gh.factory<_i11.UserApi>(() => _i11.UserApi(get<_i3.Dio>()));
  return get;
}

class _$NetworkModule extends _i12.NetworkModule {}

class _$AppModule extends _i13.AppModule {}
