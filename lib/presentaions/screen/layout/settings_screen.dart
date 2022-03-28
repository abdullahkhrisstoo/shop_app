// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/presentaions/screen/layout/home_layout/cubit/layout_cubit.dart';
import 'package:project1/presentaions/screen/login/cubit/login_cubit.dart';
import 'package:project1/presentaions/widget/toast.dart';

import '../../../constant/colors.dart';
import '../../../constant/components.dart';
import '../../../network/local/shared_pref_helper.dart';
import '../../widget/form_feild.dart';
import '../login/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController nameController = TextEditingController();

    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ProfileLoadingState,
          builder: (BuildContext context) {
            var cubit = LayoutCubit.get(context);
            emailController.text = cubit.profileModel!.data?.email ?? " ";
            phoneController.text = cubit.profileModel!.data?.phone ?? " ";
            nameController.text = cubit.profileModel!.data?.name ?? " ";
            return SingleChildScrollView(
              child: Column(
                children: [
                  textFormFeildBuilder(
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    context: context,
                    placeHolder: 'E-mail',
                    textEditingController: nameController,
                    textInputType: TextInputType.name,
                    preIcon: Icons.person,
                  ),
                  textFormFeildBuilder(
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    context: context,
                    placeHolder: 'Name',
                    textEditingController: emailController,
                    textInputType: TextInputType.emailAddress,
                    preIcon: Icons.email,
                  ),
                  textFormFeildBuilder(
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    context: context,
                    placeHolder: 'phone',
                    textEditingController: phoneController,
                    textInputType: TextInputType.phone,
                    preIcon: Icons.phone,
                  ),
                  TextButton(
                    onPressed: () {
                      CacheHelper.saveData(key: 'token', value: 'null')
                          .then((value) {
                        navigatAndFinsh(context, LoginScreen());
                      });
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
                          'logout'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      LoginCubit.get(context).updateUserData(
                        emailController.text,
                        phoneController.text,
                        nameController.text,
                      );
                      customToast(msg: "done", color: Colors.red);
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
                          'update'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          fallback: (BuildContext context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
