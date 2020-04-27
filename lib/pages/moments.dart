import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_jellow/common/api/api.dart';
import 'package:flutter_jellow/common/util/util.dart';
import 'package:flutter_jellow/common/value/color.dart';
import 'package:flutter_jellow/common/value/value.dart';
import 'package:flutter_jellow/common/widget/app.dart';
import 'package:flutter_jellow/common/widget/icon.dart';
import 'package:flutter_jellow/common/widget/image.dart';
import 'package:flutter_jellow/model/moments_vo.dart';
import 'package:flutter_jellow/pages/moments/video_play_page.dart';
import 'package:flutter_screenutil/size_extension.dart';

class MomentsPage extends StatefulWidget {
  final EasyRefreshController controller;

  const MomentsPage({Key key, this.controller}) : super(key: key);
  @override
  _MomentsPageState createState() => _MomentsPageState();
}

class _MomentsPageState extends State<MomentsPage> {
  MomentList _momentList;

  List<Data> get moments => _momentList?.data ?? [];

  @override
  void initState() {
    super.initState();
    fetchData(context);
  }

  Future<void> fetchData(BuildContext context) async {
    if (moments.isEmpty) {
      // 从本地加载
      StorageUtil().remove(STORAGE_MOMENTS_KEY);
      final Map<String, dynamic> momentMap =
          StorageUtil().getJSON(STORAGE_MOMENTS_KEY) ?? {};
      _momentList = MomentList.fromJson(momentMap);
    }

    final result = await MomentsAPI.recommendFeedList();
    _momentList.data = _momentList.data ?? [];
    _momentList.data.insertAll(0, result.data);
    StorageUtil().setJSON(STORAGE_MOMENTS_KEY, _momentList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppBar(
        context: context,
        title: Text(
          '动态广场',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.primaryBg,
      body: Container(
          padding: EdgeInsets.all(10),
          child: EasyRefresh(
            controller: widget.controller,
            header: ClassicalHeader(textColor: AppColors.primaryTxt),
            onRefresh: () async {
              print('onRefresh');
              await fetchData(context);
            },
            onLoad: () async {
              print('onload');
            },
            child: SingleChildScrollView(
                child: Column(
                    children: moments
                        .map((it) => _MomentsItem(
                              data: it,
                            ))
                        .toList())),
          )),
    );
  }
}

class _MomentsItem extends StatefulWidget {
  final Data data;

  const _MomentsItem({Key key, this.data}) : super(key: key);

  @override
  __MomentsItemState createState() => __MomentsItemState();
}

class __MomentsItemState extends State<_MomentsItem> {
  bool _fold = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _fold = isContentTooLong;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.data.user;
    return Container(
        margin: EdgeInsets.only(bottom: 18.h),
        padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 0),
        decoration: BoxDecoration(
            color: AppColors.primaryEl, borderRadius: BorderRadius.circular(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(user),
            _buildContent(),
            Container(
              margin: EdgeInsets.only(top: 18),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: multiImage(
                    context,
                    widget.data.pictures,
                  )),
            ),
            VideoPlayPage(
              video: widget.data.video,
              id: widget.data.id,
              type: widget.data.type,
              user: widget.data.user,
            ),
            _buildTopics(),
            _buildFooter()
          ],
        ));
  }

  Container _buildFooter() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 15),
      child: Row(
        children: <Widget>[
          circleIcon(icon: Icons.thumb_up),
          Expanded(
              child: circleIcon(
            icon: Icons.chat,
          )),
          circleIcon(icon: Icons.share)
        ],
      ),
    );
  }

  Container _buildTopics() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.lens,
            color: Color(0xFF7A757B),
          ),
          SizedBox(
            width: 3,
          ),
          Text(
            widget.data.topic?.content ?? '',
            style: TextStyle(color: Color(0xFF7A757B), fontSize: 13),
          )
        ],
      ),
    );
  }

  get isContentTooLong {
    return widget.data.content.length > 120;
  }

  get shortContent {
    if (widget.data.content.length > 120) {
      return widget.data.content.substring(0, 120) + '...';
    }
    return widget.data.content;
  }

  Container _buildContent() {
    if (widget.data.content.isEmpty) {
      return Container();
    }
    final normalText = Text(
      widget.data.content,
      style: TextStyle(
        color: Colors.white,
        height: 1.6,
        fontSize: 16.sp,
      ),
    );
    if (!isContentTooLong) {
      return Container(
        margin: EdgeInsets.only(top: 30.h),
        child: normalText,
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 30.h),
        child: isContentTooLong ? _foldContent() : normalText,
      );
    }
  }

  Widget _foldContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _fold ? shortContent : widget.data.content,
          maxLines: _fold ? 5 : 1000,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            height: 1.6,
            fontSize: 16,
          ),
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              _fold = !_fold;
            });
          },
          child: Text(
            _fold ? '展开' : '收起',
            style: TextStyle(color: Colors.lightBlue),
          ),
        )
      ],
    );
  }

  /// 头部
  Row _buildHeader(User user) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipOval(
            child: Image.network(
              user.avatarImage.thumbnailUrl,
              width: 45.w,
              height: 45.w,
            ),
          ),
          SizedBox(
            width: 7.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  user.screenName,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  user.briefIntro,
                  maxLines: 1,
                  style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                )
              ],
            ),
          ),
          GestureDetector(
            child: Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
            onTap: () {},
          ),
        ]);
  }
}
