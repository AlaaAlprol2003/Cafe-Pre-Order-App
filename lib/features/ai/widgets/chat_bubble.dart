import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/features/ai/cubit/ai_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.isUser, required this.text});
  final bool isUser;
  final String text;
  @override
  Widget build(BuildContext context) {
    var aiCubit = BlocProvider.of<AiCubit>(context);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: REdgeInsets.symmetric(vertical: 8.h),
        padding: REdgeInsets.all(14.r),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? ColorsManager.mediumBrown : ColorsManager.white,
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
                offset:  Offset(0, 2))
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
              color: isUser ? ColorsManager.white : Colors.black87,
              fontSize: 15.sp,
              height: 1.4),
        ),
      ),
    );
  }
}
