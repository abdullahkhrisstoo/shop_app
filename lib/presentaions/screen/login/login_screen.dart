// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/constant/colors.dart';
import 'package:project1/constant/components.dart';
import 'package:project1/network/local/shared_pref_helper.dart';
import 'package:project1/presentaions/screen/login/cubit/login_cubit.dart';
import 'package:project1/presentaions/screen/login/register_screen.dart';
import '../../widget/form_feild.dart';
import '../../widget/toast.dart';
import '../layout/home_layout/home_screen.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSucess) {
          if (state.userLoginModel.status == true) {
            customToast(
                color: Colors.green, msg: state.userLoginModel.message);
            CacheHelper.saveData(
              key: 'token',
              value: state.userLoginModel.data?.token,
            ).then((value) {
              navigatAndFinsh(context, HomeScreen());
            });
          } else {
            customToast(color: Colors.red, msg: state.userLoginModel.message);
          }
        }
      },
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
                        "lOGIN",
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
                            return "Enter your Email";
                          }
                          return null;
                        },
                        context: context,
                        placeHolder: 'email',
                        textEditingController: emailController,
                        textInputType: TextInputType.emailAddress,
                        preIcon: Icons.email_rounded,
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
                        placeHolder: 'passWord',
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
                      SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoad,
                        builder: (BuildContext context) => TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  emailController.text,
                                  passwordController.text);
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
                                'login'.toUpperCase(),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have An account ? ",
                            style: TextStyle(
                              fontSize: 16,
                              color: ConstantColor.secondeyColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navigatTo(context, RegisterScreen());
                            },
                            child: Text(
                              'register',
                              style: TextStyle(
                                fontSize: 16,
                                color: ConstantColor.primaryColor,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
