import 'package:flutter_bloc/flutter_bloc.dart';

class OfferDetailsCubit extends Cubit<OfferDetailsState> {
  OfferDetailsCubit() : super(OfferDetailsInitial());
  Map<String, String> selectedOptions = {};
  void changeOption(String title, String option) {
    if (selectedOptions[title] == option) {
      selectedOptions.remove(title);
    } else {
      selectedOptions[title] = option;
    }

    emit(ChangeOptionState(Map.from(selectedOptions)));
  }
}

abstract class OfferDetailsState {}

class OfferDetailsInitial extends OfferDetailsState {}

class ChangeOptionState extends OfferDetailsState {
  final Map<String, String> selectedOptions;
  ChangeOptionState(this.selectedOptions);
}
