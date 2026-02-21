abstract class AuthState {}

class AuthInitial extends AuthState {}

class PasswordVisibilityState extends AuthState {}

class PasswordVisibilityStateLog extends AuthState {}

class AnimatedToggleState extends AuthState {}

class AuthToggleLoadingState extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterFailure extends AuthState {
  String message;
  RegisterFailure({required this.message});
}

class RegisterSuccess extends AuthState {}

class AddUserToFirestoreSuccess extends AuthState {}

class AddUserToFirestoreFailure extends AuthState {
  String message;
  AddUserToFirestoreFailure({required this.message});
}

class LoginLoading extends AuthState {}

class LoginFailure extends AuthState {
  String message;
  LoginFailure({required this.message});
}

class LoginSuccess extends AuthState {}

class GetUserFromFirestoreLoading extends AuthState {}

class GetUserFromFirestoreFailure extends AuthState {
  String message;
  GetUserFromFirestoreFailure({required this.message});
}

class GetUserFromFirestoreSuccess extends AuthState {}
