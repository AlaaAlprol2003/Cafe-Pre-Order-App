// ignore_for_file: unused_element

import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/core/resources/validators.dart';
import 'package:dash_cup/core/widgets/custom_elevated_button.dart';
import 'package:dash_cup/core/widgets/custom_text_button.dart';
import 'package:dash_cup/core/widgets/custom_text_form_field.dart';
import 'package:dash_cup/features/auth/presentation/screens/register/cubit/auth_cubit.dart';
import 'package:dash_cup/features/auth/presentation/screens/register/cubit/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.only(top: 150),
          child: Column(
            children: [
              Image.asset(ImageAssets.logo, height: 135.h),
              SizedBox(height: 50.h),
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
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        labelText: "Email",
                        preIcon: Icon(Icons.email),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: Validator.email,
                      ),
                      SizedBox(height: 16.h),
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
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        labelText: "Phone Number",
                        preIcon: Icon(Icons.phone),
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        validator: Validator.phone,
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already Have Account? ",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          CustomTextButton(text: "Login", onPressed: () {}),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      CustomElevatedButton(
                        text: "Register",
                        onPressed: () {
                          if (_formKey.currentState?.validate() == false)
                            return;
                        },
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
