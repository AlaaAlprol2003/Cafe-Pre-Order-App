import 'package:dash_cup/features/auth/data/models/login_request.dart';
import 'package:dash_cup/features/auth/data/models/register_request.dart';
import 'package:dash_cup/features/auth/data/models/user.dart';
import 'package:dash_cup/features/auth/domain/use_cases/add_user_to_firestore_use_case.dart';
import 'package:dash_cup/features/auth/domain/use_cases/get_user_from_firestore_use_case.dart';
import 'package:dash_cup/features/auth/domain/use_cases/login_use_case.dart';
import 'package:dash_cup/features/auth/domain/use_cases/register_use_case.dart';
import 'package:dash_cup/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:dash_cup/features/auth/presentation/cubit/auth_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.registerUseCase,
    required this.addUserToFirestoreUseCase,
    required this.loginUseCase,
    required this.getUserFromfirestoreUseCase,
    required this.resetPasswordUseCase,
  }) : super(AuthInitial());
  RegisterUseCase registerUseCase;
  AddUserToFirestoreUseCase addUserToFirestoreUseCase;
  LoginUseCase loginUseCase;
  GetUserFromfirestoreUseCase getUserFromfirestoreUseCase;
  ResetPasswordUseCase resetPasswordUseCase;
  bool isSecuredField = true;
  bool isSecuredFieldLog = true;
  int currentValue = 0;
  bool isToggleLoading = false;
  UserCredential? userCredential;
  void changeVisibilityState() {
    isSecuredField = !isSecuredField;
    emit(PasswordVisibilityState());
  }

  void changeVisibilityStateLog() {
    isSecuredFieldLog = !isSecuredFieldLog;
    emit(PasswordVisibilityStateLog());
  }

  void changeToggleValue({required int value}) async {
    isToggleLoading = true;
    emit(AuthToggleLoadingState());

    await Future.delayed(const Duration(seconds: 1));
    currentValue = value;
    isToggleLoading = false;
    emit(AnimatedToggleState());
  }

  Future<void> register({
    required RegisterRequest request,
    required String name,
    required String phone,
  }) async {
    emit(RegisterLoading());

    final response = await registerUseCase(request: request);

    await response.fold(
      ifLeft: (failure) async {
        emit(RegisterFailure(message: failure.message));
      },
      ifRight: (credential) async {
        userCredential = credential;

        final userModel = UserModel(
          id: credential.user!.uid,
          name: name,
          email: request.email,
          password: request.password,
          phone: phone,
          points: 0,
          favoriteItems: [],
        );

        final result = await addUserToFirestoreUseCase(user: userModel);

        result.fold(
          ifLeft: (failure) => emit(RegisterFailure(message: failure.message)),
          ifRight: (_) => emit(RegisterSuccess()),
        );
      },
    );
  }

  Future<void> login({required LoginRequest request}) async {
    emit(LoginLoading());
    final result = await loginUseCase(request: request);
    result.fold(
      ifLeft: (failure) {
        emit(LoginFailure(message: failure.message));
      },
      ifRight: (_) {
        emit(LoginSuccess());
      },
    );
  }

  void getUserFromFirestore({required String userId}) async {
    emit(GetUserFromFirestoreLoading());
    final result = await getUserFromfirestoreUseCase(userId: userId);
    result.fold(
      ifLeft: (failure) {
        emit(GetUserFromFirestoreFailure(message: failure.message));
      },
      ifRight: (user) {
        UserModel.currentUser = user;
        emit(GetUserFromFirestoreSuccess());
      },
    );
  }

  void resetPassword({required String email}) async {
    emit(ResetPasswordloading());
    final result = await resetPasswordUseCase(email: email);
    result.fold(
      ifLeft: (failure) {
        emit(ResetPasswordFailure(message: failure.message));
      },
      ifRight: (user) {
        emit(ResetPasswordSuccess());
      },
    );
  }
}
