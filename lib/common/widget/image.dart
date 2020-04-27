import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jellow/model/moments_vo.dart';
import 'package:flutter_jellow/pages/moments/photo_view_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/size_extension.dart';

Widget multiImage(BuildContext context, List<Picture> list) {
  int length = list?.length ?? 0;
  if (length == 0) {
    return Container();
  }
  final imageUrls = list.map((it) => it.picUrl).toList();
  if (length == 1) {
    final image = list.first;
    if (image.width > image.height) {
      return imageViewer(
          context: context,
          index: 0,
          child: Image.network(
            image.middlePicUrl,
            width: 200.w,
            fit: BoxFit.cover,
          ),
          photoUrls: imageUrls);
    } else {
      return imageViewer(
          context: context,
          index: 0,
          child: Image.network(
            image.middlePicUrl,
            height: 200.h,
          ),
          photoUrls: imageUrls);
    }
  } else {
    int remain = length;
    final widgets = <Widget>[];
    while (remain > 0) {
      int take = 0;
      if ((remain ~/ 3) > 0) {
        take = 3;
      } else {
        take = remain % 3;
      }
      remain = remain - take;
      final row = imageRow(
          context, list.sublist(remain, remain + take), remain, imageUrls);
      widgets.add(row);
    }

    final newWidgets = <Widget>[];
    for (int i = widgets.length - 1; i >= 0; i--) {
      newWidgets.add(widgets[i]);
      if (i != 0) {
        newWidgets.add(SizedBox(
          height: 1.h,
        ));
      }
    }

    return Column(mainAxisSize: MainAxisSize.min, children: newWidgets);
  }
}

Widget imageRow(BuildContext context, List<Picture> list, int startIndex,
    List<String> imageUrls) {
  assert(list.length <= 3, 'length must <= 3: ${list.length}');
  double width = list.length == 1 ? 362 : 360 / list.length;

  final widgets = <Widget>[];
  for (int i = 0; i < list.length; i++) {
    widgets.add(imageViewer(
        context: context,
        index: startIndex + i,
        child: ConstrainedBox(
          child: Image.network(
            list.length == 1 ? list[i].middlePicUrl : list[i].thumbnailUrl,
            width: width.w,
            height: width.h,
            fit: BoxFit.cover,
          ),
          constraints: BoxConstraints(maxHeight: 150.h),
        ),
        photoUrls: imageUrls));

    // 不是最后一个, 添加一个间隔
    if (i != list.length - 1) {
      widgets.add(SizedBox(
        width: 1.w,
      ));
    }
  }
  return Row(children: widgets);
}

Widget imageViewer(
    {@required BuildContext context,
    @required int index,
    @required Widget child,
    @required photoUrls}) {
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

/// 缓存图片
Widget imageCached(
  String url, {
  double width = 48,
  double height = 48,
  EdgeInsetsGeometry margin,
}) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, imageProvider) => Container(
      height: height.h,
      width: width.w,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
        ),
      ),
    ),
    placeholder: (context, url) {
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    },
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
