// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
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
import '../../features/booking/data/datasource/booking_remote_datasource.dart'
    as _i569;
import '../../features/booking/data/repository/booking_repository_impl.dart'
    as _i472;
import '../../features/booking/domain/repository/booking_repo.dart' as _i1040;
import '../../features/booking/presentation/cubit/booking_cubit.dart' as _i329;
import '../../features/product_details/data/data_source/order_firebase_remote_data_source.dart'
    as _i480;
import '../../features/product_details/data/data_source/order_remote_data_source.dart'
    as _i800;
import '../../features/product_details/data/repository_impl/order_repository_impl.dart'
    as _i278;
import '../../features/product_details/domain/repository/order_repository.dart'
    as _i770;
import '../../features/product_details/domain/use_case/add_order_to_firestore_use_case.dart'
    as _i941;
import '../../features/product_details/domain/use_case/delete_order_from_firestore_use_case.dart'
    as _i455;
import '../../features/product_details/domain/use_case/get_orders_use_case.dart'
    as _i443;
import '../../features/product_details/domain/use_case/update_order_quantity_use_case.dart'
    as _i307;
import '../../features/product_details/presentation/cubit/product_details_cubit.dart'
    as _i4;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i800.OrderRemoteDataSource>(
        () => _i480.OrderFirebaseRemoteDataSource());
    gh.singleton<_i25.AuthRemoteDataSsource>(
        () => _i293.AuthFirebaseRemoteDataSource());
    gh.lazySingleton<_i569.BookingRemoteDataSource>(
        () => _i569.BookingRemoteDataSource(gh<_i974.FirebaseFirestore>()));
    gh.singleton<_i961.AuthRepository>(() => _i954.AuthRepositoriesImpl(
        remoteDataSsource: gh<_i25.AuthRemoteDataSsource>()));
    gh.lazySingleton<_i770.OrderRepository>(() => _i278.OrderRepositoryImpl(
        orderRemoteDataSource: gh<_i800.OrderRemoteDataSource>()));
    gh.singleton<_i431.AddUserToFirestoreUseCase>(() =>
        _i431.AddUserToFirestoreUseCase(
            authRepository: gh<_i961.AuthRepository>()));
    gh.singleton<_i557.GetUserFromfirestoreUseCase>(() =>
        _i557.GetUserFromfirestoreUseCase(
            authRepository: gh<_i961.AuthRepository>()));
    gh.singleton<_i1038.LoginUseCase>(
        () => _i1038.LoginUseCase(authRepository: gh<_i961.AuthRepository>()));
    gh.singleton<_i1010.RegisterUseCase>(() =>
        _i1010.RegisterUseCase(authRepository: gh<_i961.AuthRepository>()));
    gh.singleton<_i169.ResetPasswordUseCase>(() =>
        _i169.ResetPasswordUseCase(authRepository: gh<_i961.AuthRepository>()));
    gh.lazySingleton<_i941.AddOrderToFirestoreUseCase>(() =>
        _i941.AddOrderToFirestoreUseCase(
            orderRepository: gh<_i770.OrderRepository>()));
    gh.lazySingleton<_i455.DeleteOrderFromFirestoreUseCase>(() =>
        _i455.DeleteOrderFromFirestoreUseCase(
            orderRepository: gh<_i770.OrderRepository>()));
    gh.lazySingleton<_i443.GetOrdersFromFirestoreUseCase>(() =>
        _i443.GetOrdersFromFirestoreUseCase(
            orderRepository: gh<_i770.OrderRepository>()));
    gh.lazySingleton<_i307.UpdateOrderQuantityUseCase>(() =>
        _i307.UpdateOrderQuantityUseCase(
            orderRepository: gh<_i770.OrderRepository>()));
    gh.factory<_i117.AuthCubit>(() => _i117.AuthCubit(
          registerUseCase: gh<_i1010.RegisterUseCase>(),
          addUserToFirestoreUseCase: gh<_i431.AddUserToFirestoreUseCase>(),
          loginUseCase: gh<_i1038.LoginUseCase>(),
          getUserFromfirestoreUseCase: gh<_i557.GetUserFromfirestoreUseCase>(),
          resetPasswordUseCase: gh<_i169.ResetPasswordUseCase>(),
        ));
    gh.lazySingleton<_i1040.BookingRepo>(
        () => _i472.BookingRepositoryImpl(gh<_i569.BookingRemoteDataSource>()));
    gh.factory<_i329.BookingCubit>(
        () => _i329.BookingCubit(gh<_i1040.BookingRepo>()));
    gh.factory<_i4.ProductDetailsCubit>(() => _i4.ProductDetailsCubit(
          addOrderToFirestoreUseCase: gh<_i941.AddOrderToFirestoreUseCase>(),
          getOrdersFromFirestoreUseCase:
              gh<_i443.GetOrdersFromFirestoreUseCase>(),
          deleteOrderFromFirestoreUseCase:
              gh<_i455.DeleteOrderFromFirestoreUseCase>(),
        ));
    return this;
  }
}
