import 'package:flutter/material.dart';
import 'package:flutter_jellow/common/value/color.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool> toastInfo(
    {@required String msg,
    Color backgroundColor = AppColors.primaryBg,
    Color textColor = AppColors.primaryTxt,
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM}) async {
  return await Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.sp);
}
