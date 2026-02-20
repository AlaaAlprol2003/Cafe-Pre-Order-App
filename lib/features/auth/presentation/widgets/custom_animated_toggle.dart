import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dash_cup/features/auth/presentation/cubit/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAnimatedToggle extends StatefulWidget {
  const CustomAnimatedToggle({super.key});

  @override
  State<CustomAnimatedToggle> createState() => _CustomAnimatedToggleState();
}

class _CustomAnimatedToggleState extends State<CustomAnimatedToggle> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AuthCubit>(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return AnimatedToggleSwitch<int>.rolling(
          current: cubit.currentValue,
          values: [0, 1],
          onChanged: (i) async {
            cubit.changeToggleValue(value: i);
          },
          loading: cubit.isToggleLoading,
          iconList: [
            Icon(Icons.dark_mode, size: 30, color: Colors.black),
            Icon(Icons.light_mode, size: 30, color: ColorsManager.white),
          ],
          indicatorAnimationType: AnimationType.onHover,
          style: ToggleStyle(
            backgroundColor: ColorsManager.charcoalBlue,
            borderColor: ColorsManager.burntOrange,
            indicatorBorder: BoxBorder.all(
              color: ColorsManager.burntOrange,
              width: 2,
            ),
            indicatorColor: ColorsManager.burntOrange,
          ),
          iconsTappable: true,
          indicatorTransition: ForegroundIndicatorTransition.fading(),
        );
      },
    );
  }
}
