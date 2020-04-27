import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_jellow/common/util/http.dart';
import 'package:flutter_jellow/common/widget/toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewPage extends StatefulWidget {
  final List<String> photoUrls;
  final int initIndex;

  const PhotoViewPage({Key key, @required this.photoUrls, this.initIndex = 0})
      : super(key: key);

  @override
  _PhotoViewPageState createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  PageController _controller;

  /// 当前页码
  int _currentPage;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initIndex);
    _currentPage = widget.initIndex;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () async {
          final url = widget.photoUrls[_currentPage];
          print(url);
          final resp = await HttpUtil().getBytes(url);

          if (await Permission.storage.request().isGranted) {
            final String result = await ImageGallerySaver.saveImage(
                Uint8List.fromList(resp.data));

            String message =
                '图片已保存至 ${result.substring(0, result.lastIndexOf('/'))} 文件夹';

            toastInfo(msg: message, toastLength: Toast.LENGTH_LONG);
          }
        },
        icon: Icon(Icons.get_app),
      ),
      body: Stack(
        children: <Widget>[
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                onTapUp: (_, __, ___) {
                  Navigator.of(context).pop();
                },
                imageProvider: NetworkImage(widget.photoUrls[index]),
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 1.1,
              );
            },
            pageController: _controller,
            itemCount: widget.photoUrls.length,
            onPageChanged: onPageChanged,
          ),
          Positioned(
            child: Align(
              alignment: Alignment(0, 0.8),
              child: Text(
                '${_currentPage + 1}/${widget.photoUrls.length}',
                style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Colors.white70),
              ),
            ),
          )
        ],
      ),
    );
  }

  void onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }
}
