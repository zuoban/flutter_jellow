import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';

const _circleIconBgColor = const Color(0xFF2A2A2A);
const _circleIconTxtColor = const Color(0xFF878787);

/// 圆形图标
Widget circleIcon({IconData icon}) {
  return Container(
    padding: EdgeInsets.all(7.sp),
    decoration:
        BoxDecoration(shape: BoxShape.circle, color: _circleIconBgColor),
    child: Icon(
      icon,
      size: 19.sp,
      color: _circleIconTxtColor,
    ),
  );
}
