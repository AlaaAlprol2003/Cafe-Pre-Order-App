import 'package:dash_cup/features/auth/presentation/screens/register/cubit/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  bool isSecuredField = true;
  void changeVisibilityState() {
    isSecuredField = !isSecuredField;
    emit(PasswordVisibilityState());
  }
}
