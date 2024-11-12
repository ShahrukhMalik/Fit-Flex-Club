// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../../features/authentication/data/datasources/auth_remote_datasource.dart'
    as _i40;
import '../../../features/authentication/data/repositories/auth_repository_impl.dart'
    as _i441;
import '../../../features/authentication/domain/repositories/auth_repository.dart'
    as _i20;
import '../../../features/authentication/domain/usecases/create_account_usecase.dart'
    as _i955;
import '../../../features/authentication/domain/usecases/forgot_password_usecase.dart'
    as _i988;
import '../../../features/authentication/domain/usecases/login_usecase.dart'
    as _i831;
import '../../../features/authentication/domain/usecases/logout_usecase.dart'
    as _i447;
import '../../../features/authentication/presentation/bloc/authentication_bloc.dart'
    as _i70;
import '../../../features/client_profile/data/datasources/client_profile_remote_datasource.dart'
    as _i305;
import '../../../features/client_profile/data/repositories/client_profile_repository_impl.dart'
    as _i560;
import '../../../features/client_profile/domain/repositories/client_profile_repository.dart'
    as _i627;
import '../../../features/client_profile/domain/usecases/add_user_usecase.dart'
    as _i541;
import '../../../features/client_profile/domain/usecases/is_client_profile_created_usecase.dart'
    as _i617;
import '../../../features/client_profile/domain/usecases/is_user_active_usecase.dart'
    as _i899;
import '../../../features/client_profile/domain/usecases/update_user_usecase.dart'
    as _i864;
import '../../../features/client_profile/presentation/bloc/client_profile_bloc.dart'
    as _i268;
import '../../util/module/register_module.dart' as _i19;
import '../../util/network/network_info.dart' as _i228;
import '../widgets/platform_button.dart' as _i769;

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
    gh.singleton<_i769.PlatformButton>(() => _i769.PlatformButton());
    gh.singleton<_i228.NetworkInfo>(() => _i228.NetworkInfoImpl(
        connectionChecker: gh<_i973.InternetConnectionChecker>()));
    gh.singleton<_i305.ClientProfileRemoteDatasource>(
        () => _i305.ClientProfileRemoteDatasourceImpl(
              auth: gh<_i59.FirebaseAuth>(),
              db: gh<_i974.FirebaseFirestore>(),
            ));
    gh.singleton<_i627.ClientProfileRepository>(
        () => _i560.ClientProfileRepositoryImpl(
              networkInfo: gh<_i228.NetworkInfo>(),
              clientProfileRemoteDatasource:
                  gh<_i305.ClientProfileRemoteDatasource>(),
            ));
    gh.singleton<_i617.IsClientProfileCreatedActiveUsecase>(() =>
        _i617.IsClientProfileCreatedActiveUsecaseImpl(
            clientProfileRepository: gh<_i627.ClientProfileRepository>()));
    gh.singleton<_i40.AuthRemoteDatasource>(
        () => _i40.AuthRemoteDatasourceImpl(auth: gh<_i59.FirebaseAuth>()));
    gh.singleton<_i541.AddUserUsecase>(() => _i541.AddUserUsecaseImpl(
        clientProfileRepository: gh<_i627.ClientProfileRepository>()));
    gh.singleton<_i899.IsUserActiveUsecase>(() => _i899.IsUserActiveUsecaseImpl(
        clientProfileRepository: gh<_i627.ClientProfileRepository>()));
    gh.singleton<_i864.UpdateUserUsecase>(() => _i864.UpdateUserUsecaseImpl(
        clientProfileRepository: gh<_i627.ClientProfileRepository>()));
    gh.singleton<_i20.AuthRepository>(() => _i441.AuthRepositoryImpl(
          remoteDatasource: gh<_i40.AuthRemoteDatasource>(),
          networkInfo: gh<_i228.NetworkInfo>(),
        ));
    gh.singleton<_i831.LogInUsecase>(() =>
        _i831.LogInUsecaseImpl(authRepository: gh<_i20.AuthRepository>()));
    gh.singleton<_i988.ForgotPasswordUsecase>(() =>
        _i988.ForgotPasswordUsecaseImpl(
            authRepository: gh<_i20.AuthRepository>()));
    gh.singleton<_i955.CreateAccountUsecase>(() =>
        _i955.CreateAccountUsecaseImpl(
            authRepository: gh<_i20.AuthRepository>()));
    gh.singleton<_i447.LogOutUsecase>(() =>
        _i447.LogOutUsecaseImpl(authRepository: gh<_i20.AuthRepository>()));
    gh.factory<_i268.ClientProfileBloc>(() => _i268.ClientProfileBloc(
          gh<_i541.AddUserUsecase>(),
          gh<_i864.UpdateUserUsecase>(),
          gh<_i617.IsClientProfileCreatedActiveUsecase>(),
          gh<_i899.IsUserActiveUsecase>(),
        ));
    gh.factory<_i70.AuthenticationBloc>(() => _i70.AuthenticationBloc(
          createAccountUsecase: gh<_i955.CreateAccountUsecase>(),
          logInUsecase: gh<_i831.LogInUsecase>(),
          logOutUsecase: gh<_i447.LogOutUsecase>(),
          forgotPasswordUsecase: gh<_i988.ForgotPasswordUsecase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i19.RegisterModule {}
