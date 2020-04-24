import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DynamicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.message),
              onPressed: () {},
            )
          ],
          title: Container(
            margin: EdgeInsets.only(left: 40),
            child: Center(
              child: Text(
                'Jellow',
                style: GoogleFonts.parisienne(
                    fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ),
        ),
        body: Text('动态'));
  }
}
