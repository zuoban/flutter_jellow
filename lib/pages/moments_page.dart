import 'package:flutter/material.dart';
import 'package:flutter_jellow/model/moments_vo.dart';
import 'package:flutter_jellow/pages/moments/moments_photo.dart';
import 'package:flutter_jellow/pages/moments/video_play_page.dart';
import 'package:flutter_jellow/request/requests.dart';
import 'package:flutter_jellow/widgets/pack_icon.dart';

class MomentsPage extends StatefulWidget {
  @override
  _MomentsPageState createState() => _MomentsPageState();
}

class _MomentsPageState extends State<MomentsPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            '动态广场',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
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
          )
        ],
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
                user: widget.data.user,
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
    final normalText = Text(
      widget.data.content,
      style: TextStyle(
        color: Colors.white,
        height: 1.6,
        fontSize: 16,
      ),
    );
    if (!isContentTooLong) {
      return Container(
        margin: EdgeInsets.only(top: 12),
        child: normalText,
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 12),
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
