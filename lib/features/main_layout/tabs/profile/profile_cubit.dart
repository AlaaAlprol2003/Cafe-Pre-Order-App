import 'package:dash_cup/features/auth/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProfileStates {}
class ProfileInitialState extends ProfileStates {}
class ProfileUpdateLoadingState extends ProfileStates {}
class ProfileUpdateSuccessState extends ProfileStates {}
class ProfileUpdateErrorState extends ProfileStates {
  final String error;
  ProfileUpdateErrorState(this.error);
}
class ProfileLoadingState extends ProfileStates {}
class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  void updateProfile({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(ProfileUpdateLoadingState());

    UserModel.currentUser!.name = name;
    UserModel.currentUser!.phone = phone;
    UserModel.currentUser!.email = email;

    FirebaseFirestore.instance
        .collection('Users')
        .doc(UserModel.currentUser!.id)
        .update(UserModel.currentUser!.toJson())
        .then((value) {
      emit(ProfileUpdateSuccessState());
    }).catchError((error) {
      emit(ProfileUpdateErrorState(error.toString()));
    });
  }

  
void getUserData() {
  emit(ProfileLoadingState()); 
  
  FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) {
    if (value.data() != null) {
      UserModel.currentUser = UserModel.fromJson(value.data()!);
      emit(ProfileUpdateSuccessState()); 
    }
  });
}
}