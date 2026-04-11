import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/features/ai/cubit/ai_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputArea extends StatelessWidget {
  const InputArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var aiCubit = BlocProvider.of<AiCubit>(context);

    return Container(
      padding:
          EdgeInsets.only(left: 10.w, right: 10.w, bottom: 25.h, top: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.eggshell,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10.r)],
      ),
      child: BlocBuilder<AiCubit, AiState>(
        builder: (context, state) {
          return Row(
            children: [
              // زرار الكاميرا للتعرف على الصور
              GestureDetector(
                onTap: aiCubit.handleImagePick,
                child: CircleAvatar(
                  backgroundColor: ColorsManager.darkChocolate,
                  child: Icon(Icons.camera_alt,
                      color: ColorsManager.creamyWhite, size: 20.sp),
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: aiCubit.toggleListening,
                child: CircleAvatar(
                  backgroundColor: aiCubit.isListening
                      ? Colors.red
                      : ColorsManager.darkChocolate,
                  child: Icon(aiCubit.isListening ? Icons.stop : Icons.mic,
                      color: ColorsManager.creamyWhite),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  controller: aiCubit.controller,
                  onSubmitted: (_) => aiCubit.handleSendMessage(),
                  decoration: InputDecoration(
                    hintText: aiCubit.isListening
                        ? "Listening..."
                        : "كيف يمكنني مساعدتك؟",
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
                onTap: aiCubit.handleSendMessage,
                child: CircleAvatar(
                  backgroundColor: const Color(0xFF7B5B36),
                  child: Icon(Icons.send, color: ColorsManager.creamyWhite),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
