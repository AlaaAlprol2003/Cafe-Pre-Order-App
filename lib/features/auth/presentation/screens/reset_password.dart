import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/resources/ui_utils.dart';
import 'package:dash_cup/core/resources/validators.dart';
import 'package:dash_cup/core/widgets/custom_elevated_button.dart';
import 'package:dash_cup/core/widgets/custom_text_form_field.dart';
import 'package:dash_cup/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dash_cup/features/auth/presentation/cubit/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late TextEditingController _emailController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AuthCubit>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorsManager.darkOrange,
              size: 25,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(ImageAssets.reset),

              Padding(
                padding: REdgeInsets.only(left: 12, right: 12),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labelText: "Enter your email",
                        controller: _emailController,
                        preIcon: Icon(Icons.email),
                        keyboardType: TextInputType.emailAddress,
                        validator: Validator.email,
                      ),

                      SizedBox(height: 35.sp),
                      BlocListener<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is ResetPasswordloading) {
                            UiUtils.showLoading(context: context);
                          } else if (state is ResetPasswordFailure) {
                            UiUtils.hideLoading(context: context);
                            UiUtils.showMessage(
                              context: context,
                              message: state.message,
                              bgColor: Colors.red,
                              icon: Icons.error,
                            );
                          } else if (state is ResetPasswordSuccess) {
                            UiUtils.hideLoading(context: context);
                            UiUtils.showMessage(
                              context: context,
                              message: "Check your email and login",
                            );
                          }
                        },
                        child: CustomElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == false)
                              return;
                            cubit.resetPassword(email: _emailController.text);
                          },
                          text: "Send Reset Link",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
