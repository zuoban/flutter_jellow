import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_jellow/pages/dynamic_page.dart';
import 'package:flutter_jellow/pages/moments.dart';
import 'package:flutter_jellow/pages/my_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  EasyRefreshController _refreshController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _refreshController = EasyRefreshController();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    /// 初始化 ScreenUtil
    ScreenUtil.init(context, width: 414, height: 896);
    final List<Widget> tabBodies = [
      DynamicPage(),
      MomentsPage(
        controller: _refreshController,
      ),
      MyPage()
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightBlue,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: bottomTabs,
        onTap: (index) {
          if (index != _currentIndex) {
            setState(() {
              _currentIndex = index;
            });
          } else {
            _refreshController.callRefresh(
                duration: Duration(milliseconds: 500));
//            _scrollController.animateTo(0,
//                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          }
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: tabBodies,
      ),
    );
  }
}
