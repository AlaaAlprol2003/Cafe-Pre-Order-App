import 'package:dash_cup/features/ai/ai_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(MainLayoutInitial()) {
    generateAndSpeakGreeting();
  }

  int selectedTab = 0;
  final FlutterTts _flutterTts = FlutterTts();
  final AIService _aiService = AIService();

  void changeTab({required int index}) {
    selectedTab = index;
    emit(SelectedTabState());
  }

  void generateAndSpeakGreeting() async {
    try {
      String greeting = await _aiService.getWelcomeGreeting();

      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setPitch(1.0);
      await _flutterTts.setSpeechRate(0.45);

      await _flutterTts.speak(greeting);

      emit(WelcomeGreetingLoaded(greeting));
    } catch (e) {
      print("Error in Greeting: $e");
      await _flutterTts.speak("Welcome to Dash Cup");
    }
  }
}

abstract class MainLayoutState {}

class MainLayoutInitial extends MainLayoutState {}

class SelectedTabState extends MainLayoutState {}

class WelcomeGreetingLoaded extends MainLayoutState {
  final String greeting;
  WelcomeGreetingLoaded(this.greeting);
}
