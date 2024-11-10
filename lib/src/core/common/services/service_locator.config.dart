// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:fit_flex_club/src/core/util/module/register_module.dart'
    as _i646;
import 'package:fit_flex_club/src/core/util/network/network_info.dart' as _i969;
import 'package:fit_flex_club/src/features/authentication/data/datasources/auth_remote_datasource.dart'
    as _i754;
import 'package:fit_flex_club/src/features/authentication/data/repositories/auth_repository_impl.dart'
    as _i829;
import 'package:fit_flex_club/src/features/authentication/domain/repositories/auth_repository.dart'
    as _i163;
import 'package:fit_flex_club/src/features/authentication/domain/usecases/login_usecase.dart'
    as _i932;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i973.InternetConnectionChecker>(
        () => registerModule.internetConnectionChecker);
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i59.FirebaseAuth>(() => registerModule.auth);
    gh.factory<_i974.FirebaseFirestore>(() => registerModule.db);
    gh.singleton<_i969.NetworkInfo>(() => _i969.NetworkInfoImpl(
        connectionChecker: gh<_i973.InternetConnectionChecker>()));
    gh.singleton<_i754.AuthRemoteDatasource>(
        () => _i754.AuthRemoteDatasourceImpl(auth: gh<_i59.FirebaseAuth>()));
    gh.singleton<_i163.AuthRepository>(() => _i829.AuthRepositoryImpl(
          remoteDatasource: gh<_i754.AuthRemoteDatasource>(),
          networkInfo: gh<_i969.NetworkInfo>(),
        ));
    gh.singleton<_i932.LogInUsecase>(() =>
        _i932.LogInUsecaseImpl(authRepository: gh<_i163.AuthRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i646.RegisterModule {}
