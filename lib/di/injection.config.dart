// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data_source/local/share_refer.dart' as _i4;
import '../data_source/remote/api_client.dart' as _i5;
import '../data_source/repository/todo_repo.dart' as _i6;
import 'injectable_module.dart' as _i7; // ignore_for_file: unnecessary_lambdas

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
  final injectableModule = _$InjectableModule();
  gh.lazySingleton<_i3.Dio>(() => injectableModule.dio);
  gh.singleton<_i4.SharedPreferencesRepo>(_i4.SharedPreferencesRepo());
  gh.singleton<_i5.ApiClient>(_i5.ApiClient(
    get<_i4.SharedPreferencesRepo>(),
    get<_i3.Dio>(),
  ));
  gh.singleton<_i6.TodoRepo>(_i6.TodoRepoImpl(get<_i5.ApiClient>()));
  return get;
}

class _$InjectableModule extends _i7.InjectableModule {}
