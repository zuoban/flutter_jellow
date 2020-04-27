import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jellow/common/api/api.dart';
import 'package:flutter_jellow/model/moments_vo.dart';
import 'package:video_player/video_player.dart';

class VideoPlayPage extends StatefulWidget {
  final Video video;
  final String id;
  final String type;
  final User user;

  const VideoPlayPage(
      {Key key, @required this.video, this.id, this.type, this.user})
      : super(key: key);

  @override
  _VideoPlayPageState createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.video != null) {
      MomentsAPI.mediaMeta(id: widget.id, type: widget.type).then((result) {
        print(' playing $result');
        print(jsonEncode(widget.video));
        _controller = VideoPlayerController.network(
          result['url'],
        )..initialize().then((_) {
            setState(() {});
          });
        _controller.setLooping(true);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.video == null) {
      return Container();
    }
    return SafeArea(
      top: false,
      bottom: false,
      child: GestureDetector(
          onTap: pushFullScreenWidget, child: buildInlineVideo()),
    );
  }

  Container buildInlineVideo() {
    return Container(
      child: _controller?.value?.initialized ?? false
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: <Widget>[
                  ConstrainedBox(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    constraints: BoxConstraints(maxHeight: 260, maxWidth: 300),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  void pushFullScreenWidget() {
    final TransitionRoute<void> route = PageRouteBuilder<void>(
      settings:
          RouteSettings(name: widget.user.screenName, isInitialRoute: false),
      pageBuilder: fullScreenRoutePageBuilder,
    );

    route.completed.then((void value) {
      _controller.setVolume(0.0);
    });

    _controller.setVolume(1.0);
    Navigator.of(context).push(route);
  }

  Widget fullScreenRoutePageBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return _buildFullScreenVideo();
  }

  Widget _buildFullScreenVideo() {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(widget.user.avatarImage.thumbnailUrl),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            '${widget.user.screenName}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      )),
      body: SafeArea(
        child: Center(
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Hero(
              tag: _controller,
              child: VideoPlayPause(_controller),
            ),
          ),
        ),
      ),
    );
  }
}

class VideoPlayPause extends StatefulWidget {
  const VideoPlayPause(this.controller);

  final VideoPlayerController controller;

  @override
  State createState() => _VideoPlayPauseState();
}

class _VideoPlayPauseState extends State<VideoPlayPause> {
  _VideoPlayPauseState() {
    listener = () {
      if (mounted) setState(() {});
    };
  }

  FadeAnimation imageFadeAnimation;
  VoidCallback listener;

  VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.expand,
      children: <Widget>[
        GestureDetector(
          child: VideoPlayerLoading(controller),
          onTap: () {
            if (!controller.value.initialized) {
              return;
            }
            if (controller.value.isPlaying) {
              imageFadeAnimation = const FadeAnimation(
                child: Icon(Icons.pause, size: 100.0),
              );
              controller.pause();
            } else {
              imageFadeAnimation = const FadeAnimation(
                child: Icon(Icons.play_arrow, size: 100.0),
              );
              controller.play();
            }
          },
        ),
        Center(child: imageFadeAnimation),
      ],
    );
  }
}

class VideoPlayerLoading extends StatefulWidget {
  const VideoPlayerLoading(this.controller);

  final VideoPlayerController controller;

  @override
  _VideoPlayerLoadingState createState() => _VideoPlayerLoadingState();
}

class _VideoPlayerLoadingState extends State<VideoPlayerLoading> {
  bool _initialized;

  @override
  void initState() {
    super.initState();
    _initialized = widget.controller.value.initialized;
    widget.controller.addListener(() {
      if (!mounted) {
        return;
      }
      final bool controllerInitialized = widget.controller.value.initialized;
      if (_initialized != controllerInitialized) {
        setState(() {
          _initialized = controllerInitialized;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) {
      return VideoPlayer(widget.controller);
    }
    return Stack(
      children: <Widget>[
        VideoPlayer(widget.controller),
        const Center(child: CircularProgressIndicator()),
      ],
      fit: StackFit.expand,
    );
  }
}

class FadeAnimation extends StatefulWidget {
  const FadeAnimation({
    this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  final Widget child;
  final Duration duration;

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    animationController.forward(from: 0.0);
  }

  @override
  void deactivate() {
    animationController.stop();
    super.deactivate();
  }

  @override
  void didUpdateWidget(FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return animationController.isAnimating
        ? Opacity(
            opacity: 1.0 - animationController.value,
            child: widget.child,
          )
        : Container();
  }
}
