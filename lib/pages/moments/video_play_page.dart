import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jellow/model/moments_vo.dart';
import 'package:flutter_jellow/request/requests.dart';
import 'package:video_player/video_player.dart';

class VideoPlayPage extends StatefulWidget {
  final Video video;
  final String id;
  final String type;

  const VideoPlayPage({Key key, @required this.video, this.id, this.type})
      : super(key: key);

  @override
  _VideoPlayPageState createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  VideoPlayerController _controller;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    if (widget.video != null) {
      mediaMeta(id: widget.id, type: widget.type).then((String url) {
        print(' playing $url');
        print(jsonEncode(widget.video));
        _controller = VideoPlayerController.network(url)
          ..initialize().then((_) {
            setState(() {});
          });
        _chewieController = ChewieController(
            videoPlayerController: _controller, autoPlay: false, looping: true);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
    _chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.video == null) {
      return Container();
    }
    return Container(
      child: Center(
        child: _controller?.value?.initialized ?? false
            ? Chewie(
                controller: _chewieController,
              )
            : Container(),
      ),
    );
  }
}
