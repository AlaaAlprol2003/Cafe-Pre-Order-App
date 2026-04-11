import 'dart:io';
import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/resources/constatnt_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';

// استبدل بمسارات الملفات الحقيقية عندك
import 'ai_service.dart';

class ChatAIScreen extends StatefulWidget {
  const ChatAIScreen({super.key});

  @override
  State<ChatAIScreen> createState() => _ChatAIScreenState();
}

class _ChatAIScreenState extends State<ChatAIScreen> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final AIService _aiService = AIService();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _isListening = false;
  bool isVoiceEnabled = true;
  bool isLoading = false;
  String _lastWords = "";

  @override
  void initState() {
    super.initState();
    _initSpeech();

    String welcomeMsg =
        "Welcome to Dash Cup! I'm your AI Barista. How can I help you today?";
    _messages.add({"text": welcomeMsg, "isUser": false});
    _speak(welcomeMsg);
  }

  void _initSpeech() async {
    await _speech.initialize();
    setState(() {});
  }

  // ميزة التقاط الصور والتعرف عليها
  Future<void> _handleImagePick() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File imageFile = File(image.path);

      setState(() {
        _messages.add({
          "text": "📷 جاري تحليل الصورة لمنتجات داش كاب...",
          "isUser": true
        });
        isLoading = true;
      });
      _scrollToBottom();

      // نداء خدمة الـ Vision
      final response = await _aiService.identifyProductFromImage(
        imageFile,
        _aiService.generateMenuSummary(), // استخدام المنيو الموحد من الخدمة
      );

      if (mounted) {
        setState(() {
          isLoading = false;
          _messages.add({"text": response, "isUser": false});
        });
        _scrollToBottom();
        if (isVoiceEnabled) _speak(response);
      }
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _lastWords = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _controller.text = _lastWords;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      if (_lastWords.isNotEmpty) {
        _handleSendMessage();
      }
    }
  }

  void _handleSendMessage() async {
    String userText = _controller.text;
    if (userText.isEmpty) return;

    setState(() {
      _messages.add({"text": userText, "isUser": true});
      isLoading = true;
      _controller.clear();
      _lastWords = "";
    });

    _scrollToBottom();
    final response = await _aiService.getCoffeeAdvice(userText);

    if (mounted) {
      setState(() {
        isLoading = false;
        _messages.add({"text": response, "isUser": false});
      });
      _scrollToBottom();
    }

    if (isVoiceEnabled) _speak(response);
  }

  void _speak(String text) async {
    await _flutterTts.setSpeechRate(0.45);
    await _flutterTts.setPitch(1.0);
    bool isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);
    await _flutterTts.setLanguage(isArabic ? "ar-EG" : "en-US");
    await _flutterTts.speak(text);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.creamyWhite,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: REdgeInsets.only(bottom: 120.0),
        child: FloatingActionButton(
          onPressed: () {
            setState(() => isVoiceEnabled = !isVoiceEnabled);
            if (!isVoiceEnabled) _flutterTts.stop();
          },
          backgroundColor: ColorsManager.darkHoney,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.r)),
          child: Icon(
            isVoiceEnabled ? Icons.volume_up : Icons.volume_off,
            color: ColorsManager.creamyWhite,
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorsManager.eggshell),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Dash Barista",
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: ColorsManager.eggshell)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Icon(Icons.smart_toy_outlined,
                color: ColorsManager.eggshell, size: 30),
          ),
        ],
        backgroundColor: ColorsManager.darkChocolate,
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: REdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
              itemCount: _messages.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (isLoading && index == _messages.length) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Lottie.asset(LottieAssets.robotic, height: 70.h),
                  );
                }
                final msg = _messages[index];
                return _buildChatBubble(msg['text'], msg['isUser']);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(14.r),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFF7B5B36) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
            bottomLeft: isUser ? Radius.circular(15.r) : Radius.zero,
            bottomRight: isUser ? Radius.zero : Radius.circular(15.r),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2))
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
              color: isUser ? Colors.white : Colors.black87,
              fontSize: 15.sp,
              height: 1.4),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding:
          EdgeInsets.only(left: 10.w, right: 10.w, bottom: 25.h, top: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.eggshell,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10.r)],
      ),
      child: Row(
        children: [
          // زرار الكاميرا للتعرف على الصور
          GestureDetector(
            onTap: _handleImagePick,
            child: CircleAvatar(
              backgroundColor: ColorsManager.darkChocolate,
              child: Icon(Icons.camera_alt,
                  color: ColorsManager.creamyWhite, size: 20.sp),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: _listen,
            child: CircleAvatar(
              backgroundColor:
                  _isListening ? Colors.red : ColorsManager.darkChocolate,
              child: Icon(_isListening ? Icons.stop : Icons.mic,
                  color: ColorsManager.creamyWhite),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _handleSendMessage(),
              decoration: InputDecoration(
                hintText: _isListening ? "Listening..." : "كيف يمكنني مساعدتك؟",
                hintStyle: TextStyle(fontSize: 14.sp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.r),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: _handleSendMessage,
            child: CircleAvatar(
              backgroundColor: const Color(0xFF7B5B36),
              child: Icon(Icons.send, color: ColorsManager.creamyWhite),
            ),
          ),
        ],
      ),
    );
  }
}
