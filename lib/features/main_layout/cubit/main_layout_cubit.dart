import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(MainLayoutInitial());

  int selectedTab = 0;
  void changeTab({required int index}) {
    selectedTab = index;
    emit(SelectedTabState());
  }
}

abstract class MainLayoutState {}

class MainLayoutInitial extends MainLayoutState {}

class SelectedTabState extends MainLayoutState {}
