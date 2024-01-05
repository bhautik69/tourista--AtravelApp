import 'package:flutter/material.dart';

Widget commentextfield(
  
    {required TextEditingController controllername,
    required String? Function(String? value)? validator,
    Function(String? value)? onSubmit,
    VoidCallback? onTap,
    String? hinttext,
    bool? obscurevalue = false,
    String? lable,
    dynamic prefixicon,
    TextInputType? textInputType,
    dynamic suffixicon}) {
    
  return TextFormField(
    
    controller: controllername,
    obscureText: obscurevalue!,
    keyboardType: textInputType,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
      
        labelText: lable,
        prefixIcon: prefixicon,
        suffixIcon: suffixicon,
        hintText: hinttext,
        hintStyle: const TextStyle(
          color: Colors.black54,
        ),
        labelStyle:
            const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1.5, color: Color(0xff0078AA))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1.5, color: Colors.black54)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1.5, color: Colors.black54)),
        errorStyle: const TextStyle(color: Color(0xffB00020)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1.5, color: Color(0xffB00020)),
        )),
    validator: validator,
    onTap: () {
      onTap!();
    },
  );
}

// ignore: must_be_immutable
