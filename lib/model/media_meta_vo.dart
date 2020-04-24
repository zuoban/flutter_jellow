import 'dart:convert';

class MediaMetaVo {
  int duration;
  Map<String, dynamic> headers;
  String url;
  List<String> urls;

  MediaMetaVo({this.duration, this.headers, this.url, this.urls});

  factory MediaMetaVo.fromJson(Map<String, dynamic> json) {
    return MediaMetaVo(
      duration: json['duration'],
      headers: json['headers'] != null ? json['header'] : null,
      url: json['url'],
      urls: json['urls'] != null ? new List<String>.from(json['urls']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    data['url'] = this.url;
    if (this.headers != null) {
      data['headers'] = jsonEncode(data['header']);
    }
    if (this.urls != null) {
      data['urls'] = this.urls;
    }
    return data;
  }
}
