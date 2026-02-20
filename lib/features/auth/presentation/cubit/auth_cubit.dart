import 'package:dash_cup/features/auth/presentation/cubit/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  bool isSecuredField = true;
  bool isSecuredFieldLog = true;
  int currentValue = 0 ;
  bool isToggleLoading = false;

  void changeVisibilityState() {
    isSecuredField = !isSecuredField;
    emit(PasswordVisibilityState());
  }

  void changeVisibilityStateLog() {
    isSecuredFieldLog = !isSecuredFieldLog;
    emit(PasswordVisibilityStateLog());
  }

  void changeToggleValue({required int value})async{
    isToggleLoading = true;
    emit(AuthToggleLoadingState());

    await Future.delayed(const Duration(seconds: 1));
    currentValue = value;
    isToggleLoading = false;
    emit(AnimatedToggleState());
  }
}
