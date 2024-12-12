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
import '../../../features/authentication/domain/usecases/authenticate_user_usecase.dart'
    as _i949;
import '../../../features/authentication/domain/usecases/create_account_usecase.dart'
    as _i955;
import '../../../features/authentication/domain/usecases/forgot_password_usecase.dart'
    as _i988;
import '../../../features/authentication/domain/usecases/is_client_profile_created_usecase.dart'
    as _i98;
import '../../../features/authentication/domain/usecases/is_user_active_usecase.dart'
    as _i374;
import '../../../features/authentication/domain/usecases/login_usecase.dart'
    as _i831;
import '../../../features/authentication/domain/usecases/logout_usecase.dart'
    as _i447;
import '../../../features/authentication/presentation/bloc/authentication_bloc.dart'
    as _i70;
import '../../../features/client_profile/data/datasources/local/client_profile_local_datasource.dart'
    as _i648;
import '../../../features/client_profile/data/datasources/local/daos/client_dao.dart'
    as _i899;
import '../../../features/client_profile/data/datasources/remote/client_profile_remote_datasource.dart'
    as _i588;
import '../../../features/client_profile/data/repositories/client_profile_repository_impl.dart'
    as _i560;
import '../../../features/client_profile/domain/repositories/client_profile_repository.dart'
    as _i627;
import '../../../features/client_profile/domain/usecases/add_user_usecase.dart'
    as _i541;
import '../../../features/client_profile/domain/usecases/get_client_by_id_usecase.dart'
    as _i841;
import '../../../features/client_profile/domain/usecases/is_client_profile_created_usecase.dart'
    as _i617;
import '../../../features/client_profile/domain/usecases/is_user_active_usecase.dart'
    as _i899;
import '../../../features/client_profile/domain/usecases/update_user_usecase.dart'
    as _i864;
import '../../../features/client_profile/presentation/bloc/client_profile_bloc.dart'
    as _i268;
import '../../../features/trainer_profile/domain/usecases/get_clients_usecase.dart'
    as _i781;
import '../../../features/trainer_profile/presentation/bloc/trainer_profile_bloc.dart'
    as _i812;
import '../../../features/workout_history/data/datasources/local/daos/workout_history_dao.dart'
    as _i593;
import '../../../features/workout_history/data/datasources/local/workout_history_local_data_source.dart'
    as _i615;
import '../../../features/workout_history/data/datasources/remote/workout_history_remote_data_source.dart'
    as _i352;
import '../../../features/workout_history/data/repositories/workout_history_repository.dart'
    as _i473;
import '../../../features/workout_history/domain/repositories/workout_history_repository.dart'
    as _i198;
import '../../../features/workout_history/domain/usecases/log_workout_history_usecase.dart'
    as _i208;
import '../../../features/workout_history/presentation/bloc/workout_history_bloc.dart'
    as _i942;
import '../../../features/workout_management/data/datasources/local/daos/workout_plan_dao.dart'
    as _i939;
import '../../../features/workout_management/data/datasources/local/workout_plan_management_localdatabase.dart'
    as _i415;
import '../../../features/workout_management/data/datasources/remote/workout_plan_management_remotedatasource.dart'
    as _i826;
import '../../../features/workout_management/data/repositories/workout_management_repository_impl.dart'
    as _i1071;
import '../../../features/workout_management/domain/repositories/workout_management_repository.dart'
    as _i530;
import '../../../features/workout_management/domain/usecases/assign_workout_plan_usecase.dart'
    as _i282;
import '../../../features/workout_management/domain/usecases/create_workout_plan_usecase.dart'
    as _i853;
import '../../../features/workout_management/domain/usecases/delete_assigned_workout_plan_usecase.dart'
    as _i175;
import '../../../features/workout_management/domain/usecases/delete_workout_plan_usecase.dart'
    as _i711;
import '../../../features/workout_management/domain/usecases/get_exercises_usecase.dart'
    as _i139;
import '../../../features/workout_management/domain/usecases/get_workout_plan_for_client_usecase.dart'
    as _i91;
import '../../../features/workout_management/domain/usecases/get_workout_plans_usecase.dart'
    as _i120;
import '../../../features/workout_management/domain/usecases/update_assigned_workout_plan_usecase.dart'
    as _i661;
import '../../../features/workout_management/domain/usecases/update_workout_plan_usecase.dart'
    as _i430;
import '../../../features/workout_management/presentation/bloc/workout_management_bloc.dart'
    as _i41;
import '../../db/fit_flex_local_db.dart' as _i987;
import '../../util/module/register_module.dart' as _i19;
import '../../util/network/network_info.dart' as _i228;
import '../../util/sharedpref/shared_prefs_util.dart' as _i878;
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
    gh.singleton<_i987.AppDatabase>(() => registerModule.localDb);
    gh.singleton<_i769.PlatformButton>(() => _i769.PlatformButton());
    gh.singleton<_i826.WorkoutPlanManagementRemotedatasource>(
        () => _i826.WorkoutPlanManagementRemotedatasourceImpl(
              auth: gh<_i59.FirebaseAuth>(),
              db: gh<_i974.FirebaseFirestore>(),
            ));
    gh.singleton<_i878.SharedPrefsUtil>(
        () => _i878.SharedPrefsUtil(gh<_i460.SharedPreferences>()));
    gh.singleton<_i228.NetworkInfo>(() => _i228.NetworkInfoImpl(
        connectionChecker: gh<_i973.InternetConnectionChecker>()));
    gh.factory<_i593.WorkoutHistoryDao>(
        () => _i593.WorkoutHistoryDao(gh<_i987.AppDatabase>()));
    gh.singleton<_i588.ClientProfileRemoteDatasource>(
        () => _i588.ClientProfileRemoteDatasourceImpl(
              auth: gh<_i59.FirebaseAuth>(),
              db: gh<_i974.FirebaseFirestore>(),
            ));
    gh.singleton<_i899.ClientsDao>(
        () => _i899.ClientsDao(gh<_i987.AppDatabase>()));
    gh.singleton<_i939.WorkoutPlanDao>(
        () => _i939.WorkoutPlanDao(gh<_i987.AppDatabase>()));
    gh.singleton<_i648.ClientLocalDatasource>(
        () => _i648.ClientLocalDatasourceImpl(
              dao: gh<_i899.ClientsDao>(),
              database: gh<_i987.AppDatabase>(),
            ));
    gh.singleton<_i627.ClientProfileRepository>(
        () => _i560.ClientProfileRepositoryImpl(
              networkInfo: gh<_i228.NetworkInfo>(),
              clientProfileRemoteDatasource:
                  gh<_i588.ClientProfileRemoteDatasource>(),
              clientProfileLocalDatasource: gh<_i648.ClientLocalDatasource>(),
            ));
    gh.singleton<_i617.IsClientProfileCreatedActiveUsecase>(() =>
        _i617.IsClientProfileCreatedActiveUsecaseImpl(
            clientProfileRepository: gh<_i627.ClientProfileRepository>()));
    gh.singleton<_i541.AddUserUsecase>(() => _i541.AddUserUsecaseImpl(
        clientProfileRepository: gh<_i627.ClientProfileRepository>()));
    gh.singleton<_i899.IsUserActiveUsecase>(() => _i899.IsUserActiveUsecaseImpl(
        clientProfileRepository: gh<_i627.ClientProfileRepository>()));
    gh.singleton<_i781.GetClientsUsecaseUsecase>(() =>
        _i781.GetClientsUsecaseUsecaseImpl(
            clientProfileRepository: gh<_i627.ClientProfileRepository>()));
    gh.singleton<_i352.WorkoutHistoryRemoteDataSource>(() =>
        _i352.WorkoutHistoryRemoteDataSourceImpl(
            db: gh<_i974.FirebaseFirestore>()));
    gh.singleton<_i415.WorkoutPlanManagementLocaldatasource>(
        () => _i415.WorkoutPlanManagementLocaldatasourceImpl(
              dao: gh<_i939.WorkoutPlanDao>(),
              database: gh<_i987.AppDatabase>(),
            ));
    gh.singleton<_i864.UpdateUserUsecase>(() => _i864.UpdateUserUsecaseImpl(
        clientProfileRepository: gh<_i627.ClientProfileRepository>()));
    gh.singleton<_i615.WorkoutHistoryLocalDataSource>(
        () => _i615.WorkoutHistoryLocalDataSourceImpl(
              dao: gh<_i593.WorkoutHistoryDao>(),
              database: gh<_i987.AppDatabase>(),
            ));
    gh.singleton<_i841.GetClientByIdUsecase>(() =>
        _i841.GetClientByIdUsecaseImpl(
            clientProfileRepository: gh<_i627.ClientProfileRepository>()));
    gh.singleton<_i40.AuthRemoteDatasource>(() => _i40.AuthRemoteDatasourceImpl(
          gh<_i974.FirebaseFirestore>(),
          gh<_i878.SharedPrefsUtil>(),
          auth: gh<_i59.FirebaseAuth>(),
        ));
    gh.singleton<_i530.WorkoutManagementRepository>(
        () => _i1071.WorkoutManagementRepositoryImpl(
              networkInfo: gh<_i228.NetworkInfo>(),
              local: gh<_i415.WorkoutPlanManagementLocaldatasource>(),
              remote: gh<_i826.WorkoutPlanManagementRemotedatasource>(),
            ));
    gh.singleton<_i175.DeleteAssignedWorkoutPlanUsecase>(() =>
        _i175.DeleteAssignedWorkoutPlanUsecaseImpl(
            workoutManagementRepository:
                gh<_i530.WorkoutManagementRepository>()));
    gh.singleton<_i711.DeleteWorkoutPlanUsecase>(() =>
        _i711.DeleteWorkoutPlanUsecaseImpl(
            workoutManagementRepository:
                gh<_i530.WorkoutManagementRepository>()));
    gh.singleton<_i139.GetExercisesUsecase>(() => _i139.GetExercisesUsecaseImpl(
        workoutManagementRepository: gh<_i530.WorkoutManagementRepository>()));
    gh.factory<_i268.ClientProfileBloc>(() => _i268.ClientProfileBloc(
          gh<_i541.AddUserUsecase>(),
          gh<_i864.UpdateUserUsecase>(),
          gh<_i617.IsClientProfileCreatedActiveUsecase>(),
          gh<_i899.IsUserActiveUsecase>(),
          gh<_i841.GetClientByIdUsecase>(),
        ));
    gh.singleton<_i282.AssignWorkoutPlanUsecase>(() =>
        _i282.AssignWorkoutPlanUsecaseImpl(
            workoutManagementRepository:
                gh<_i530.WorkoutManagementRepository>()));
    gh.singleton<_i91.GetWorkoutPlansForClientUsecase>(() =>
        _i91.GetWorkoutPlansForClientUsecaseImpl(
            workoutManagementRepository:
                gh<_i530.WorkoutManagementRepository>()));
    gh.factory<_i812.TrainerProfileBloc>(
        () => _i812.TrainerProfileBloc(gh<_i781.GetClientsUsecaseUsecase>()));
    gh.singleton<_i661.UpdateAssignedWorkoutPlanUsecase>(() =>
        _i661.UpdateAssignedWorkoutPlanUsecaseImpl(
            workoutManagementRepository:
                gh<_i530.WorkoutManagementRepository>()));
    gh.singleton<_i20.AuthRepository>(() => _i441.AuthRepositoryImpl(
          remoteDatasource: gh<_i40.AuthRemoteDatasource>(),
          networkInfo: gh<_i228.NetworkInfo>(),
        ));
    gh.singleton<_i430.UpdateWorkoutPlanUsecase>(() =>
        _i430.UpdateWorkoutPlanUsecaseImpl(
            workoutManagementRepository:
                gh<_i530.WorkoutManagementRepository>()));
    gh.singleton<_i98.IsClientProfileCreatedActiveUsecase>(() =>
        _i98.IsClientProfileCreatedActiveUsecaseImpl(
            clientProfileRepository: gh<_i20.AuthRepository>()));
    gh.singleton<_i374.IsUserActiveUsecase>(() => _i374.IsUserActiveUsecaseImpl(
        clientProfileRepository: gh<_i20.AuthRepository>()));
    gh.singleton<_i831.LogInUsecase>(() =>
        _i831.LogInUsecaseImpl(authRepository: gh<_i20.AuthRepository>()));
    gh.singleton<_i988.ForgotPasswordUsecase>(() =>
        _i988.ForgotPasswordUsecaseImpl(
            authRepository: gh<_i20.AuthRepository>()));
    gh.singleton<_i949.AuthenticateUserUsecase>(() =>
        _i949.AuthenticateUserUsecaseImpl(
            authRepository: gh<_i20.AuthRepository>()));
    gh.singleton<_i955.CreateAccountUsecase>(() =>
        _i955.CreateAccountUsecaseImpl(
            authRepository: gh<_i20.AuthRepository>()));
    gh.singleton<_i447.LogOutUsecase>(() =>
        _i447.LogOutUsecaseImpl(authRepository: gh<_i20.AuthRepository>()));
    gh.singleton<_i198.WorkoutHistoryRepository>(
        () => _i473.WorkoutHistoryRepositoryImpl(
              networkInfo: gh<_i228.NetworkInfo>(),
              local: gh<_i615.WorkoutHistoryLocalDataSource>(),
              remote: gh<_i352.WorkoutHistoryRemoteDataSource>(),
            ));
    gh.singleton<_i853.CreateWorkoutPlanUsecase>(() =>
        _i853.CreateWorkoutPlanUsecaseImpl(
            workoutManagementRepository:
                gh<_i530.WorkoutManagementRepository>()));
    gh.singleton<_i120.GetWorkoutPlansUsecase>(() =>
        _i120.GetWorkoutPlansUsecaseImpl(
            workoutManagementRepository:
                gh<_i530.WorkoutManagementRepository>()));
    gh.singleton<_i208.LogWorkoutHistoryUsecase>(() =>
        _i208.LogWorkoutHistoryUsecaseImpl(
            workoutHistoryRepository: gh<_i198.WorkoutHistoryRepository>()));
    gh.factory<_i41.WorkoutManagementBloc>(() => _i41.WorkoutManagementBloc(
          gh<_i139.GetExercisesUsecase>(),
          gh<_i853.CreateWorkoutPlanUsecase>(),
          gh<_i120.GetWorkoutPlansUsecase>(),
          gh<_i430.UpdateWorkoutPlanUsecase>(),
          gh<_i282.AssignWorkoutPlanUsecase>(),
          gh<_i91.GetWorkoutPlansForClientUsecase>(),
          gh<_i175.DeleteAssignedWorkoutPlanUsecase>(),
          gh<_i711.DeleteWorkoutPlanUsecase>(),
          gh<_i661.UpdateAssignedWorkoutPlanUsecase>(),
        ));
    gh.factory<_i70.AuthenticationBloc>(() => _i70.AuthenticationBloc(
          authenticateUserUsecase: gh<_i949.AuthenticateUserUsecase>(),
          createAccountUsecase: gh<_i955.CreateAccountUsecase>(),
          logInUsecase: gh<_i831.LogInUsecase>(),
          logOutUsecase: gh<_i447.LogOutUsecase>(),
          forgotPasswordUsecase: gh<_i988.ForgotPasswordUsecase>(),
        ));
    gh.factory<_i942.WorkoutHistoryBloc>(
        () => _i942.WorkoutHistoryBloc(gh<_i208.LogWorkoutHistoryUsecase>()));
    return this;
  }
}

class _$RegisterModule extends _i19.RegisterModule {}
