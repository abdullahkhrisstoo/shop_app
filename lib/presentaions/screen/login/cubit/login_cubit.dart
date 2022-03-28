// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/constant/components.dart';
import 'package:project1/model/login_model.dart';
import 'package:project1/network/end_point.dart';
import 'package:project1/network/remote/dio_helper.dart';

import '../../../../model/login_model.dart';

part 'login_state.dart';

late UserLoginModel userLoginModel;

//todo : login

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  userLogin(
    String email,
    String password,
  ) {
    emit(LoginLoad());
    DioHelper.postData(url: login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);

      userLoginModel = UserLoginModel.fromJson(value.data);
      print(userLoginModel.status);

      emit(LoginSucess(userLoginModel));
    }).catchError((error) {
      // print("this is my catch error" + error.toString());
      emit(LoginError(error.toString()));
    });
  }

  bool isPassShow = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibility() {
    isPassShow = !isPassShow;

    suffix =
        isPassShow ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShowPassword());
  }

  //todo : register
  userRegister(
    String email,
    String password,
    String phone,
    String name,
  ) {
    emit(LoginLoad());
    DioHelper.postData(url: register, data: {
      'email': email,
      'password': password,
      'phone': phone,
      'name': name
    }).then((value) {
      print(value.data);

      userLoginModel = UserLoginModel.fromJson(value.data);
      print(userLoginModel.status);

      emit(LoginSucess(userLoginModel));
    }).catchError((error) {
      // print("this is my catch error" + error.toString());
      emit(LoginError(error.toString()));
    });
  }

  //todo : update user data
  updateUserData(
    String email,
    String phone,
    String name,
  ) {
    emit(UpdateProfileLoad());
    DioHelper.putData(
      url: updateProfile,
      data: {'email': email, 'phone': phone, 'name': name},
      token: token,
    ).then((value) {
      userLoginModel = UserLoginModel.fromJson(value.data);

      emit(LoginSucess(userLoginModel));
    }).catchError((error) {
      emit(LoginError(error.toString()));
    });
  }
}
