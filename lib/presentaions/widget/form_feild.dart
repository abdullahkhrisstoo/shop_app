import 'package:flutter/material.dart';
import 'package:project1/constant/colors.dart';

Widget textFormFeildBuilder({
    required BuildContext context,
    int? maxLength,
    required TextInputType textInputType,
    required String placeHolder,
    IconData? preIcon,
    required TextEditingController textEditingController,
    Function()? onTap,
    void Function(String)? onChanged,
    void Function(String?)? onSaved,
    bool isPass = false,
    String? Function(String?)? validate,
    IconButton? sufixButton,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: textEditingController,
        onTap: onTap,
        obscureText: isPass,
        validator: validate,
        maxLength: maxLength,
        style: Theme.of(context).textTheme.headline1,
        keyboardType: textInputType,
        decoration: InputDecoration(
            labelText: placeHolder,
            labelStyle: TextStyle(color: ConstantColor.primaryColor),
            contentPadding: const EdgeInsets.all(15.0),
            prefixIcon: Icon(
              preIcon,
              color: ConstantColor.primaryColor,
            ),
            suffixIcon: sufixButton,
            errorStyle: TextStyle(
              color: ConstantColor.errorColor,
              fontWeight: FontWeight.w700,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0),
              borderSide: const BorderSide(
                color: Color(0xFF26b78b),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0),
              borderSide: BorderSide(
                color: ConstantColor.secondeyColor,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0),
              borderSide: BorderSide(
                color: ConstantColor.primaryColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0),
              borderSide: BorderSide(
                color: ConstantColor.errorColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0),
              borderSide: BorderSide(
                color: ConstantColor.primaryColor,
              ),
            ),
            focusColor: ConstantColor.primaryColor),
        onChanged: onChanged,
        onSaved: onSaved,
      ),
    );
  }

