import 'package:flutter/material.dart';
import 'package:flutter_jellow/model/moments_vo.dart';
import 'package:flutter_jellow/pages/moments/photo_view_page.dart';

class MomentsPhoto extends StatelessWidget {
  final List<Picture> photos;

  final List<String> photoUrls;

  MomentsPhoto({Key key, this.photos})
      : photoUrls = photos.map((p) => p.picUrl).toList(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildImages(context);
  }

  Widget _buildImages(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 52;

    if (photos.isEmpty) {
      return Container();
    }
    Widget firstImage;
    if (photos.first.width > photos.first.height) {
      firstImage = Image.network(
        photos[0].picUrl,
        width: width,
        height: 200,
        fit: BoxFit.cover,
      );
    } else {
      firstImage = Image.network(
        photos.first.picUrl,
        height: 200,
      );
    }

    Widget firstImageCover = Image.network(
      photoUrls.first,
      width: width,
      height: 200,
      fit: BoxFit.cover,
    );

    firstImage =
        _photoTapWrapper(context: context, index: 0, child: firstImage);

    firstImageCover =
        _photoTapWrapper(context: context, index: 0, child: firstImageCover);

    if (photos.length == 1) {
      return firstImage;
    }
    if (photos.length == 2) {
      return _twoImagesPerRow(context, photos, 0);
    }
    if (photos.length == 3) {
      return _threeImagesPerRow(context, photos, 0);
    }
    if (photos.length == 4) {
      return Column(
        children: <Widget>[
          firstImageCover,
          _threeImagesPerRow(context, photos, 1)
        ],
      );
    }
    if (photos.length == 5) {
      return Column(
        children: <Widget>[
          _twoImagesPerRow(context, photos, 0),
          _threeImagesPerRow(context, photos, 2),
        ],
      );
    }
    if (photos.length == 6) {
      return Column(
        children: <Widget>[
          _threeImagesPerRow(context, photos, 0),
          _threeImagesPerRow(context, photos, 3),
        ],
      );
    }

    if (photos.length == 7) {
      return Column(
        children: <Widget>[
          firstImageCover,
          _threeImagesPerRow(context, photos, 1),
          _threeImagesPerRow(context, photos, 4),
        ],
      );
    }

    if (photos.length == 8) {
      return Column(
        children: <Widget>[
          _twoImagesPerRow(context, photos, 0),
          _threeImagesPerRow(context, photos, 2),
          _threeImagesPerRow(context, photos, 5),
        ],
      );
    }

    if (photos.length == 9) {
      return Column(
        children: <Widget>[
          _threeImagesPerRow(context, photos, 0),
          _threeImagesPerRow(context, photos, 3),
          _threeImagesPerRow(context, photos, 6),
        ],
      );
    }

    return Container();
  }

  Widget _threeImagesPerRow(
      BuildContext context, List<Picture> images, int startIndex) {
    images = images.sublist(startIndex, startIndex + 3);
    assert(images.length == 3, '_threeImagesPerRow images length must be 3');
    final width = MediaQuery.of(context).size.width - 54;
    return Row(
        children: images.map((img) {
      return _photoTapWrapper(
          context: context,
          index: startIndex++,
          child: Container(
            margin: EdgeInsets.all(0.5),
            child: Image.network(
              img.thumbnailUrl,
              width: width / 3,
              height: width / 3,
              fit: BoxFit.cover,
            ),
          ));
    }).toList());
  }

  Widget _twoImagesPerRow(
      BuildContext context, List<Picture> images, int startIndex) {
    images = images.sublist(startIndex, startIndex + 2);
    assert(images.length == 2, '_threeImagesPerRow images length must be 2');
    final width = MediaQuery.of(context).size.width - 53;
    return Row(
        children: images.map((img) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (BuildContext context) {
            return new PhotoViewPage(
              photoUrls: images.map((f) => f.picUrl).toList(),
              initIndex: startIndex++,
            );
          }));
        },
        child: Container(
          margin: EdgeInsets.all(0.5),
          child: Image.network(
            img.thumbnailUrl,
            width: width / 2,
            height: width / 2,
            fit: BoxFit.cover,
          ),
        ),
      );
    }).toList());
  }

  Widget _photoTapWrapper(
      {@required BuildContext context,
      @required int index,
      @required Widget child}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(new MaterialPageRoute(builder: (BuildContext context) {
          return new PhotoViewPage(
            photoUrls: photoUrls,
            initIndex: index,
          );
        }));
      },
      child: child,
    );
  }
}
