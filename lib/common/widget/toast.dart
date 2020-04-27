import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool> toastInfo(
    {@required String msg,
    Color backgroundColor = Colors.yellow,
    Color textColor = Colors.black}) async {
  return await Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.sp);
}
