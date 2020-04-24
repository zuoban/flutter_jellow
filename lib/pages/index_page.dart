import 'package:flutter/material.dart';
import 'package:flutter_jellow/pages/dynamic_page.dart';
import 'package:flutter_jellow/pages/moments_page.dart';
import 'package:flutter_jellow/pages/my_page.dart';
import 'package:flutter_jellow/provide/index_page_provide.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.group,
          size: 30,
        ),
        title: Text(
          '动态',
          style: TextStyle(fontSize: 14),
        )),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.description,
        size: 30,
      ),
      title: Text(
        '广场',
        style: TextStyle(fontSize: 14),
      ),
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          size: 30,
        ),
        title: Text(
          '我的',
          style: TextStyle(fontSize: 14),
        )),
  ];

  final List<Widget> tabBodies = [DynamicPage(), MomentsPage(), MyPage()];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => IndexPageProvide(),
        child: Consumer<IndexPageProvide>(builder:
            (BuildContext context, IndexPageProvide value, Widget child) {
          return Scaffold(
            backgroundColor: Colors.black,
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.lightBlue,
              backgroundColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              currentIndex: value.currentIndex,
              items: bottomTabs,
              onTap: (index) {
                print(index);
                value.changeIndex(index);
              },
            ),
            body: IndexedStack(
              index: value.currentIndex,
              children: tabBodies,
            ),
          );
        }));
  }
}
