import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/core/resources/validators.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/core/widgets/custom_elevated_button.dart';
import 'package:dash_cup/core/widgets/custom_text_button.dart';
import 'package:dash_cup/core/widgets/custom_text_form_field.dart';
import 'package:dash_cup/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dash_cup/features/auth/presentation/cubit/auth_states.dart';
import 'package:dash_cup/features/auth/presentation/widgets/custom_animated_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AuthCubit>(context);
    return GestureDetector(
      onTap:(){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.only(top: 170.0),
            child: Column(
              children: [
                Image.asset(
                  ImageAssets.logo,
                  height: 135.h,
                  width: double.infinity,
                ),
                SizedBox(height: 50.h),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: REdgeInsets.only(right: 16.0, left: 16),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          labelText: "Email",
                          preIcon: Icon(Icons.email),
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: Validator.email,
                        ),
                        SizedBox(height: 24.h),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return CustomTextFormField(
                              labelText: "Password",
                              isSecured: cubit.isSecuredFieldLog,
                              preIcon: Icon(Icons.password),
                              postIcon: IconButton(
                                onPressed: () {
                                  cubit.changeVisibilityStateLog();
                                },
                                icon: Icon(
                                  cubit.isSecuredFieldLog
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordController,
                              validator: Validator.password,
                            );
                          },
                        ),
                        SizedBox(height: 24.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomTextButton(onPressed: (){}, text: "Forget Password")),
                        SizedBox(height: 24.h),
                        CustomElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == false)
                              return;
                          },
                          text: "Login",
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Have Account? ",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            CustomTextButton(
                              text: "Create One",
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.register);
                              },
                            ),
                          ],
                        ),
                        
                        Padding(
                          padding:  REdgeInsets.only(top: 60.0),
                          child: CustomAnimatedToggle(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
