import 'package:dash_cup/features/auth/data/models/login_request.dart';
import 'package:dash_cup/features/auth/data/models/register_request.dart';
import 'package:dash_cup/features/auth/data/models/user.dart';
import 'package:dash_cup/features/auth/domain/use_cases/add_user_to_firestore_use_case.dart';
import 'package:dash_cup/features/auth/domain/use_cases/get_user_from_firestore_use_case.dart';
import 'package:dash_cup/features/auth/domain/use_cases/login_use_case.dart';
import 'package:dash_cup/features/auth/domain/use_cases/register_use_case.dart';
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
  }) : super(AuthInitial());
  RegisterUseCase registerUseCase;
  AddUserToFirestoreUseCase addUserToFirestoreUseCase;
  LoginUseCase loginUseCase;
  GetUserFromfirestoreUseCase getUserFromfirestoreUseCase;
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

  Future<void> register({required RegisterRequest request}) async {
    emit(RegisterLoading());
    final response = await registerUseCase(request: request);
    response.fold(
      ifLeft: (failure) {
        emit(RegisterFailure(message: failure.message));
      },
      ifRight: (credential) {
        userCredential = credential;
        emit(RegisterSuccess());
      },
    );
  }

  void addUserToFirestore({required UserModel user}) async {
    final result = await addUserToFirestoreUseCase(user: user);
    result.fold(
      ifLeft: (failure) {
        emit(AddUserToFirestoreFailure(message: failure.message));
      },
      ifRight: (_) {
        emit(AddUserToFirestoreSuccess());
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
}
