import 'package:flutter/material.dart';
import 'package:flutter_jellow/constant/theme.dart';

class PackIcon extends StatelessWidget {
  final IconData icon;

  const PackIcon({Key key, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(shape: BoxShape.circle, color: c_icon_bg),
        child: Icon(
          icon,
          size: 19,
          color: c_text_assist,
        ));
  }
}
