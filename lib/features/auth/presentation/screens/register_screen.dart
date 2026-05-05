// ignore_for_file: unused_element, curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'dart:io';

import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/core/resources/ui_utils.dart';
import 'package:dash_cup/core/resources/validators.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/core/widgets/custom_elevated_button.dart';
import 'package:dash_cup/core/widgets/custom_text_button.dart';
import 'package:dash_cup/core/widgets/custom_text_form_field.dart';
import 'package:dash_cup/features/auth/data/models/register_request.dart';
import 'package:dash_cup/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dash_cup/features/auth/presentation/cubit/auth_states.dart';
import 'package:dash_cup/features/auth/presentation/widgets/custom_privacy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
 

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();

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
        body: SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.only(top: 130),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600.w),
                child: Column(
                  children: [
                    Image.asset(ImageAssets.logo, height: 145.h),
                    
                    SizedBox(height: 30.h),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: REdgeInsets.only(left: 16.0, right: 16),
                        child: Column(
                          children: [
                            CustomTextFormField(
                              labelText: "Name",
                              preIcon: Icon(Icons.person),
                              controller: _nameController,
                              validator: Validator.name,
                            ),
                            SizedBox(height: 24.h),
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
                                  isSecured: cubit.isSecuredField,
                                  preIcon: Icon(Icons.password),
                                  postIcon: IconButton(
                                    onPressed: () {
                                      cubit.changeVisibilityState();
                                    },
                                    icon: Icon(
                                      cubit.isSecuredField
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
                            CustomTextFormField(
                              labelText: "Phone Number",
                              preIcon: Icon(Icons.phone),
                              keyboardType: TextInputType.phone,
                              controller: _phoneController,
                              validator: Validator.phone,
                            ),
                            SizedBox(height: 30.h),
                            CustomPrivacyText(),
                            SizedBox(height: 16.h),
                            BlocListener<AuthCubit, AuthState>(
                              listenWhen: (previous, current) {
                                if (current is RegisterLoading ||
                                    current is RegisterFailure) {
                                  return true;
                                }
                                if (current is RegisterSuccess &&
                                    previous is! RegisterSuccess) {
                                  return true;
                                }
                                return false;
                              },
                              listener: (context, state) {
                                if (state is RegisterLoading) {
                                  UiUtils.showLoading(context: context);
                                } else if (state is RegisterFailure) {
                                  UiUtils.hideLoading(context: context);
                                  UiUtils.showMessage(
                                    context: context,
                                    message: state.message,
                                    bgColor: Colors.red,
                                    icon: Icons.error,
                                  );
                                } else if (state is RegisterSuccess) {
                                  UiUtils.hideLoading(context: context);
                                  UiUtils.showMessage(
                                    context: context,
                                    message: "Account created successfully!",
                                  );
                                  Future.delayed(
                                    const Duration(milliseconds: 200),
                                    () {
                                      if (mounted) {
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          AppRoutes.login,
                                          (route) => false,
                                        );
                                      }
                                    },
                                  );
                                }
                              },
                              child: CustomElevatedButton(
                                text: "Register",
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ==
                                      false) return;
                                  cubit.register(
                                    request: RegisterRequest(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                    name: _nameController.text,
                                    phone: _phoneController.text,
                                   
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already Have Account? ",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                CustomTextButton(
                                  text: "Login",
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.login);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
