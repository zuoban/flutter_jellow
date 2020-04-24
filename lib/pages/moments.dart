import 'package:flutter/material.dart';
import 'package:flutter_jellow/model/moments_vo.dart';
import 'package:flutter_jellow/pages/moments/moments_photo.dart';
import 'package:flutter_jellow/pages/moments/video_play_page.dart';
import 'package:flutter_jellow/request/requests.dart';
import 'package:flutter_jellow/widgets/pack_icon.dart';

class Moments extends StatefulWidget {
  @override
  _MomentsState createState() => _MomentsState();
}

class _MomentsState extends State<Moments> {
  MomentsVo _momentsVo;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future fetchData() async {
    final resp = await recommendFeedList();

    setState(() {
      _momentsVo = resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_momentsVo == null) {
      return CircularProgressIndicator();
    }
    return Expanded(
      child: RefreshIndicator(
        child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: _momentsVo.data
                .map((it) => _MomentsItem(
                      data: it,
                    ))
                .toList()),
        onRefresh: () {
          return fetchData();
        },
      ),
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
  @override
  Widget build(BuildContext context) {
    final user = widget.data.user;
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
        decoration: BoxDecoration(
            color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
          decoration: BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(user),
              _buildContent(),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: MomentsPhoto(
                      photos: widget.data.pictures,
                    )),
              ),
              VideoPlayPage(
                video: widget.data.video,
                id: widget.data.id,
                type: widget.data.type,
              ),
              _buildTopics(),
              _buildFooter()
            ],
          ),
        ));
  }

  Container _buildFooter() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 15),
      child: Row(
        children: <Widget>[
          PackIcon(icon: Icons.thumb_up),
          Expanded(
              child: PackIcon(
            icon: Icons.chat,
          )),
          PackIcon(icon: Icons.share)
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

  Container _buildContent() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Text(
        widget.data.content,
        style: TextStyle(
          color: Colors.white,
          height: 1.8,
          fontSize: 17,
        ),
      ),
    );
  }

  /// 头部
  Row _buildHeader(User user) {
    return Row(children: <Widget>[
      CircleAvatar(
          backgroundImage: NetworkImage(user.avatarImage.thumbnailUrl)),
      Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                user.screenName,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                user.briefIntro,
                maxLines: 1,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              )
            ],
          ),
        ),
      ),
      InkWell(
        child: Icon(
          Icons.more_horiz,
          color: Colors.white,
        ),
        onTap: () {},
      ),
    ]);
  }
}
