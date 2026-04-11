// ignore_for_file: unused_field

import 'dart:io';

import 'package:dash_cup/features/ai/ai_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AiCubit extends Cubit<AiState> {
  final AIService _aiService = AIService();
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText speech = stt.SpeechToText();
  final ImagePicker _picker = ImagePicker();

  bool isListening = false;
  bool isVoiceEnabled = true;

  AiCubit() : super(AiInitial()) {
    initWelcome();
  }
  void initWelcome() async {
    String welcomeMsg =
        "Welcome to Dash Cup! I'm your AI Barista. How can I help you today?";
    messages.add({"text": welcomeMsg, "isUser": false});
    emit(AiSuccess(List.from(messages)));

    await Future.delayed(Duration(milliseconds: 500));
    _speak(welcomeMsg);
  }

  // ميزة تحليل الصور
  Future<void> handleImagePick() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      messages.add(
          {"text": "📷 جاري تحليل الصورة لمنتجات داش كاب...", "isUser": true});
      emit(AiLoading()); // عشان نظهر الـ Lottie
      _scrollToBottom();

      final response = await _aiService.identifyProductFromImage(
        File(image.path),
        _aiService.generateMenuSummary(),
      );

      messages.add({"text": response, "isUser": false});
      if (isVoiceEnabled) _speak(response);

      emit(AiSuccess(List.from(messages)));
      _scrollToBottom();
    }
  }

  // إرسال رسالة نصية
  Future<void> handleSendMessage() async {
    String userText = controller.text.trim();
    if (userText.isEmpty) return;

    messages.add({"text": userText, "isUser": true});
    controller.clear();
    emit(AiLoading());
    _scrollToBottom();

    final response = await _aiService.getCoffeeAdvice(userText);

    messages.add({"text": response, "isUser": false});
    if (isVoiceEnabled) _speak(response);

    emit(AiSuccess(List.from(messages)));
    _scrollToBottom();
  }

  void toggleVoice() {
    isVoiceEnabled = !isVoiceEnabled;
    if (!isVoiceEnabled) flutterTts.stop();
    emit(AiSuccess(List.from(messages))); // تحديث الـ UI (شكل الأيقونة)
  }

  void _speak(String text) async {
    await flutterTts.setSpeechRate(0.45);
    bool isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);
    await flutterTts.setLanguage(isArabic ? "ar-EG" : "en-US");
    await flutterTts.speak(text);
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void toggleListening() async {
    if (!isListening) {
      bool available = await speech.initialize();
      if (available) {
        isListening = true;
        emit(AiSuccess(List.from(messages))); // عشان نغير لون المايك للأحمر

        speech.listen(
          onResult: (val) {
            controller.text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              // اختياري: ممكن تبعت الرسالة تلقائياً أول ما يخلص كلام
            }
          },
        );
      }
    } else {
      isListening = false;
      speech.stop();
      emit(AiSuccess(List.from(messages))); // رجع لون المايك طبيعي

      if (controller.text.trim().isNotEmpty) {
        handleSendMessage();
      }
    }
  }
}

abstract class AiState {}

class AiInitial extends AiState {}

class AiLoading extends AiState {} // لما الـ AI بيفكر

class AiSuccess extends AiState {
  // لما الـ AI يرد
  final List<Map<String, dynamic>> messages;
  AiSuccess(this.messages);
}

class AiError extends AiState {
  final String message;
  AiError(this.message);
}
