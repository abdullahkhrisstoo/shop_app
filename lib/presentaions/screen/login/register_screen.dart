// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/colors.dart';
import '../../widget/form_feild.dart';
import 'cubit/login_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "register",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: ConstantColor.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "lOGIN to brwose clothes",
                          style: TextStyle(
                            fontSize: 16,
                            color: ConstantColor.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        textFormFeildBuilder(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Enter your name";
                            }
                            return null;
                          },
                          context: context,
                          placeHolder: 'name',
                          textEditingController: nameController,
                          textInputType: TextInputType.name,
                          preIcon: Icons.person,
                        ),
                        textFormFeildBuilder(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Enter your Email";
                            }
                            return null;
                          },
                          context: context,
                          placeHolder: 'email',
                          textEditingController: emailController,
                          textInputType: TextInputType.emailAddress,
                          preIcon: Icons.email,
                        ),
                        textFormFeildBuilder(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Enter your pass";
                            }
                            return null;
                          },
                          isPass: LoginCubit.get(context).isPassShow,
                          context: context,
                          placeHolder: 'password',
                          textEditingController: passwordController,
                          textInputType: TextInputType.emailAddress,
                          preIcon: Icons.key,
                          sufixButton: IconButton(
                            onPressed: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            icon: Icon(
                              LoginCubit.get(context).suffix,
                            ),
                            color: ConstantColor.primaryColor,
                          ),
                        ),
                        textFormFeildBuilder(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Enter your phone";
                            }
                            return null;
                          },
                          context: context,
                          placeHolder: 'phone',
                          textEditingController: phoneController,
                          textInputType: TextInputType.phone,
                          preIcon: Icons.phone,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoad,
                          builder: (BuildContext context) => TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                LoginCubit.get(context).userRegister(
                                  emailController.text,
                                  passwordController.text,
                                  phoneController.text,
                                  nameController.text,
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular((10)),
                                  color: ConstantColor.primaryColor),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              width: double.infinity,
                              height: 50,
                              child: Center(
                                child: Text(
                                  'register'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          fallback: (BuildContext context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
          ;
        });
  }
}
