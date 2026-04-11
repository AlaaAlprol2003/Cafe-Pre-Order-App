import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/features/ai/cubit/ai_cubit.dart';
import 'package:dash_cup/features/ai/widgets/chat_bubble.dart';
import 'package:dash_cup/features/ai/widgets/input_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';


class ChatAIScreen extends StatelessWidget {
  const ChatAIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var aiCubit = BlocProvider.of<AiCubit>(context);
    return Scaffold(
      backgroundColor: ColorsManager.creamyWhite,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: REdgeInsets.only(bottom: 120.0),
        child: BlocBuilder<AiCubit, AiState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                aiCubit.toggleVoice();
              },
              backgroundColor: ColorsManager.darkHoney,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.r)),
              child: Icon(
                aiCubit.isVoiceEnabled ? Icons.volume_up : Icons.volume_off,
                color: ColorsManager.creamyWhite,
              ),
            );
          },
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
            padding: REdgeInsets.only(right: 15.w),
            child: Icon(Icons.smart_toy_outlined,
                color: ColorsManager.eggshell, size: 30),
          ),
        ],
        backgroundColor: ColorsManager.darkChocolate,
        centerTitle: true,
        elevation: 2,
      ),
      body: BlocBuilder<AiCubit, AiState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: aiCubit.scrollController,
                  padding:
                      REdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                  itemCount:
                      aiCubit.messages.length + (state is AiLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (state is AiLoading &&
                        index == aiCubit.messages.length) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Lottie.asset(LottieAssets.robotic, height: 70.h),
                      );
                    }
                    final msg = aiCubit.messages[index];
                    return ChatBubble(text: msg['text'], isUser: msg['isUser']);
                  },
                ),
              ),
              InputArea(),
            ],
          );
        },
      ),
    );
  }
}
