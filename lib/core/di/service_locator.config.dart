// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data_sources/auth_firebase_remote_data_source.dart'
    as _i293;
import '../../features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i25;
import '../../features/auth/data/repository_impl/auth_repository_impl.dart'
    as _i954;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/domain/use_cases/add_user_to_firestore_use_case.dart'
    as _i431;
import '../../features/auth/domain/use_cases/get_user_from_firestore_use_case.dart'
    as _i557;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i1038;
import '../../features/auth/domain/use_cases/register_use_case.dart' as _i1010;
import '../../features/auth/domain/use_cases/reset_password_use_case.dart'
    as _i169;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i25.AuthRemoteDataSsource>(
      () => _i293.AuthFirebaseRemoteDataSource(),
    );
    gh.singleton<_i961.AuthRepository>(
      () => _i954.AuthRepositoriesImpl(
        remoteDataSsource: gh<_i25.AuthRemoteDataSsource>(),
      ),
    );
    gh.singleton<_i431.AddUserToFirestoreUseCase>(
      () => _i431.AddUserToFirestoreUseCase(
        authRepository: gh<_i961.AuthRepository>(),
      ),
    );
    gh.singleton<_i557.GetUserFromfirestoreUseCase>(
      () => _i557.GetUserFromfirestoreUseCase(
        authRepository: gh<_i961.AuthRepository>(),
      ),
    );
    gh.singleton<_i1038.LoginUseCase>(
      () => _i1038.LoginUseCase(authRepository: gh<_i961.AuthRepository>()),
    );
    gh.singleton<_i1010.RegisterUseCase>(
      () => _i1010.RegisterUseCase(authRepository: gh<_i961.AuthRepository>()),
    );
    gh.singleton<_i169.ResetPasswordUseCase>(
      () => _i169.ResetPasswordUseCase(
        authRepository: gh<_i961.AuthRepository>(),
      ),
    );
    gh.factory<_i117.AuthCubit>(
      () => _i117.AuthCubit(
        registerUseCase: gh<_i1010.RegisterUseCase>(),
        addUserToFirestoreUseCase: gh<_i431.AddUserToFirestoreUseCase>(),
        loginUseCase: gh<_i1038.LoginUseCase>(),
        getUserFromfirestoreUseCase: gh<_i557.GetUserFromfirestoreUseCase>(),
        resetPasswordUseCase: gh<_i169.ResetPasswordUseCase>(),
      ),
    );
    return this;
  }
}
