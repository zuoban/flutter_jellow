import 'package:flutter/material.dart';
import 'package:flutter_jellow/common/provider/moment_provide.dart';
import 'package:flutter_jellow/global.dart';
import 'package:flutter_jellow/pages/index_page.dart';
import 'package:provider/provider.dart';

void main() {
  Global.init().then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MomentProvider>(
          create: (_) => MomentProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          accentColor: Color(0XFFB2B2B2),
        ),
        routes: {
          "/": (_) => IndexPage(),
        },
        initialRoute: "/",
      ),
    );
  }
}
