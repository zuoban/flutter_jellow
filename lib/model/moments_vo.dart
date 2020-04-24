class MomentsVo {
  List<Data> data;
  LoadMoreKey loadMoreKey;
  String toastMessage;

  MomentsVo({this.data, this.loadMoreKey, this.toastMessage});

  factory MomentsVo.fromJson(Map<String, dynamic> json) {
    return MomentsVo(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
      loadMoreKey: json['loadMoreKey'] != null
          ? LoadMoreKey.fromJson(json['loadMoreKey'])
          : null,
      toastMessage: json['toastMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toastMessage'] = this.toastMessage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.loadMoreKey != null) {
      data['loadMoreKey'] = this.loadMoreKey.toJson();
    }
    return data;
  }
}

class Data {
  bool collected;
  int commentCount;
  String content;
  String createdAt;
  bool enablePictureComments;
  String id;
  bool isCommentForbidden;
  bool isFeatured;
  int likeCount;
  List<Picture> pictures;
  ReadTrackInfo readTrackInfo;
  int repostCount;
  Rollouts rollouts;
  List<ScrollingSubtitle> scrollingSubtitles;
  int shareCount;
  String status;
  String subtitle;
  Topic topic;
  String type;
  List<dynamic> urlsInText;
  User user;
  Video video;

  Data(
      {this.collected,
      this.commentCount,
      this.content,
      this.createdAt,
      this.enablePictureComments,
      this.id,
      this.isCommentForbidden,
      this.isFeatured,
      this.likeCount,
      this.pictures,
      this.readTrackInfo,
      this.repostCount,
      this.rollouts,
      this.scrollingSubtitles,
      this.shareCount,
      this.status,
      this.subtitle,
      this.topic,
      this.type,
      this.urlsInText,
      this.user,
      this.video});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      collected: json['collected'],
      commentCount: json['commentCount'],
      content: json['content'],
      createdAt: json['createdAt'],
      enablePictureComments: json['enablePictureComments'],
      id: json['id'],
      isCommentForbidden: json['isCommentForbidden'],
      isFeatured: json['isFeatured'],
      likeCount: json['likeCount'],
      pictures: json['pictures'] != null
          ? (json['pictures'] as List).map((i) => Picture.fromJson(i)).toList()
          : null,
      readTrackInfo: json['readTrackInfo'] != null
          ? ReadTrackInfo.fromJson(json['readTrackInfo'])
          : null,
      repostCount: json['repostCount'],
      rollouts:
          json['rollouts'] != null ? Rollouts.fromJson(json['rollouts']) : null,
      scrollingSubtitles: json['scrollingSubtitles'] != null
          ? (json['scrollingSubtitles'] as List)
              .map((i) => ScrollingSubtitle.fromJson(i))
              .toList()
          : null,
      shareCount: json['shareCount'],
      status: json['status'],
      subtitle: json['subtitle'],
      topic: json['topic'] != null ? Topic.fromJson(json['topic']) : null,
      type: json['type'],
      urlsInText:
          json['urlsInText'] != null ? (json['urlsInText'] as List) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      video: json['video'] != null ? Video.fromJson(json['video']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collected'] = this.collected;
    data['commentCount'] = this.commentCount;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    data['enablePictureComments'] = this.enablePictureComments;
    data['id'] = this.id;
    data['isCommentForbidden'] = this.isCommentForbidden;
    data['isFeatured'] = this.isFeatured;
    data['likeCount'] = this.likeCount;
    data['repostCount'] = this.repostCount;
    data['shareCount'] = this.shareCount;
    data['status'] = this.status;
    data['subtitle'] = this.subtitle;
    data['type'] = this.type;
    if (this.pictures != null) {
      data['pictures'] = this.pictures.map((v) => v.toJson()).toList();
    }
    if (this.readTrackInfo != null) {
      data['readTrackInfo'] = this.readTrackInfo.toJson();
    }
    if (this.rollouts != null) {
      data['rollouts'] = this.rollouts.toJson();
    }
    if (this.scrollingSubtitles != null) {
      data['scrollingSubtitles'] =
          this.scrollingSubtitles.map((v) => v.toJson()).toList();
    }
    if (this.topic != null) {
      data['topic'] = this.topic.toJson();
    }
    if (this.urlsInText != null) {
      data['urlsInText'] = this.urlsInText.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.video != null) {
      data['video'] = this.video.toJson();
    }
    return data;
  }
}

class Rollouts {
  WmpShare wmpShare;

  Rollouts({this.wmpShare});

  factory Rollouts.fromJson(Map<String, dynamic> json) {
    return Rollouts(
      wmpShare:
          json['wmpShare'] != null ? WmpShare.fromJson(json['wmpShare']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wmpShare != null) {
      data['wmpShare'] = this.wmpShare.toJson();
    }
    return data;
  }
}

class WmpShare {
  String id;
  String path;

  WmpShare({this.id, this.path});

  factory WmpShare.fromJson(Map<String, dynamic> json) {
    return WmpShare(
      id: json['id'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    return data;
  }
}

class Picture {
  double cropperPosX;
  double cropperPosY;
  String format;
  int height;
  String middlePicUrl;
  String picUrl;
  String smallPicUrl;
  String thumbnailUrl;
  String watermarkPicUrl;
  int width;

  Picture(
      {this.cropperPosX,
      this.cropperPosY,
      this.format,
      this.height,
      this.middlePicUrl,
      this.picUrl,
      this.smallPicUrl,
      this.thumbnailUrl,
      this.watermarkPicUrl,
      this.width});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      cropperPosX: json['cropperPosX'],
      cropperPosY: json['cropperPosY']?.toDouble(),
      format: json['format'],
      height: json['height'],
      middlePicUrl: json['middlePicUrl'],
      picUrl: json['picUrl'],
      smallPicUrl: json['smallPicUrl'],
      thumbnailUrl: json['thumbnailUrl'],
      watermarkPicUrl: json['watermarkPicUrl'],
      width: json['width'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cropperPosX'] = this.cropperPosX;
    data['cropperPosY'] = this.cropperPosY;
    data['format'] = this.format;
    data['height'] = this.height;
    data['middlePicUrl'] = this.middlePicUrl;
    data['picUrl'] = this.picUrl;
    data['smallPicUrl'] = this.smallPicUrl;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['watermarkPicUrl'] = this.watermarkPicUrl;
    data['width'] = this.width;
    return data;
  }
}

class ScrollingSubtitle {
  String text;
  String type;

  ScrollingSubtitle({this.text, this.type});

  factory ScrollingSubtitle.fromJson(Map<String, dynamic> json) {
    return ScrollingSubtitle(
      text: json['text'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['type'] = this.type;
    return data;
  }
}

class User {
  AvatarImage avatarImage;
  BackgroundImage backgroundImage;
  String bio;
  String briefIntro;
  String createdAt;
  String id;
  bool isVerified;
  String profileImageUrl;
  String ref;
  String screenName;
  StatsCount statsCount;
  String updatedAt;
  String username;
  String verifyMessage;

  User(
      {this.avatarImage,
      this.backgroundImage,
      this.bio,
      this.briefIntro,
      this.createdAt,
      this.id,
      this.isVerified,
      this.profileImageUrl,
      this.ref,
      this.screenName,
      this.statsCount,
      this.updatedAt,
      this.username,
      this.verifyMessage});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      avatarImage: json['avatarImage'] != null
          ? AvatarImage.fromJson(json['avatarImage'])
          : null,
      backgroundImage: json['backgroundImage'] != null
          ? BackgroundImage.fromJson(json['backgroundImage'])
          : null,
      bio: json['bio'],
      briefIntro: json['briefIntro'],
      createdAt: json['createdAt'],
      id: json['id'],
      isVerified: json['isVerified'],
      profileImageUrl: json['profileImageUrl'],
      ref: json['ref'],
      screenName: json['screenName'],
      statsCount: json['statsCount'] != null
          ? StatsCount.fromJson(json['statsCount'])
          : null,
      updatedAt: json['updatedAt'],
      username: json['username'],
      verifyMessage: json['verifyMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bio'] = this.bio;
    data['briefIntro'] = this.briefIntro;
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    data['isVerified'] = this.isVerified;
    data['profileImageUrl'] = this.profileImageUrl;
    data['ref'] = this.ref;
    data['screenName'] = this.screenName;
    data['updatedAt'] = this.updatedAt;
    data['username'] = this.username;
    data['verifyMessage'] = this.verifyMessage;
    if (this.avatarImage != null) {
      data['avatarImage'] = this.avatarImage.toJson();
    }
    if (this.backgroundImage != null) {
      data['backgroundImage'] = this.backgroundImage.toJson();
    }
    if (this.statsCount != null) {
      data['statsCount'] = this.statsCount.toJson();
    }
    return data;
  }
}

class StatsCount {
  int followedCount;
  int followingCount;
  int highlightedPersonalUpdates;
  int liked;
  int topicCreated;
  int topicSubscribed;

  StatsCount(
      {this.followedCount,
      this.followingCount,
      this.highlightedPersonalUpdates,
      this.liked,
      this.topicCreated,
      this.topicSubscribed});

  factory StatsCount.fromJson(Map<String, dynamic> json) {
    return StatsCount(
      followedCount: json['followedCount'],
      followingCount: json['followingCount'],
      highlightedPersonalUpdates: json['highlightedPersonalUpdates'],
      liked: json['liked'],
      topicCreated: json['topicCreated'],
      topicSubscribed: json['topicSubscribed'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['followedCount'] = this.followedCount;
    data['followingCount'] = this.followingCount;
    data['highlightedPersonalUpdates'] = this.highlightedPersonalUpdates;
    data['liked'] = this.liked;
    data['topicCreated'] = this.topicCreated;
    data['topicSubscribed'] = this.topicSubscribed;
    return data;
  }
}

class BackgroundImage {
  String picUrl;

  BackgroundImage({this.picUrl});

  factory BackgroundImage.fromJson(Map<String, dynamic> json) {
    return BackgroundImage(
      picUrl: json['picUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['picUrl'] = this.picUrl;
    return data;
  }
}

class AvatarImage {
  String badgeUrl;
  String format;
  String middlePicUrl;
  String picUrl;
  String smallPicUrl;
  String thumbnailUrl;

  AvatarImage(
      {this.badgeUrl,
      this.format,
      this.middlePicUrl,
      this.picUrl,
      this.smallPicUrl,
      this.thumbnailUrl});

  factory AvatarImage.fromJson(Map<String, dynamic> json) {
    return AvatarImage(
      badgeUrl: json['badgeUrl'],
      format: json['format'],
      middlePicUrl: json['middlePicUrl'],
      picUrl: json['picUrl'],
      smallPicUrl: json['smallPicUrl'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['badgeUrl'] = this.badgeUrl;
    data['format'] = this.format;
    data['middlePicUrl'] = this.middlePicUrl;
    data['picUrl'] = this.picUrl;
    data['smallPicUrl'] = this.smallPicUrl;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}

class Topic {
  String approximateSubscribersCount;
  String briefIntro;
  String content;
  bool enablePictureComments;
  bool enablePictureWatermark;
  String id;
  bool inShortcuts;
  String intro;
  bool isCommentForbidden;
  bool isUserTopicAdmin;
  bool isValid;
  String lastMessagePostTime;
  String likeIcon;
  String operateStatus;
  String ref;
  SquarePicture squarePicture;
  String squarePostUpdateTime;
  int subscribedStatusRawValue;
  String subscribersAction;
  int subscribersCount;
  String subscribersDescription;
  String subscribersName;
  String subscribersTextSuffix;
  Tips tips;
  String topicType;
  String type;

  Topic(
      {this.approximateSubscribersCount,
      this.briefIntro,
      this.content,
      this.enablePictureComments,
      this.enablePictureWatermark,
      this.id,
      this.inShortcuts,
      this.intro,
      this.isCommentForbidden,
      this.isUserTopicAdmin,
      this.isValid,
      this.lastMessagePostTime,
      this.likeIcon,
      this.operateStatus,
      this.ref,
      this.squarePicture,
      this.squarePostUpdateTime,
      this.subscribedStatusRawValue,
      this.subscribersAction,
      this.subscribersCount,
      this.subscribersDescription,
      this.subscribersName,
      this.subscribersTextSuffix,
      this.tips,
      this.topicType,
      this.type});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      approximateSubscribersCount: json['approximateSubscribersCount'],
      briefIntro: json['briefIntro'],
      content: json['content'],
      enablePictureComments: json['enablePictureComments'],
      enablePictureWatermark: json['enablePictureWatermark'],
      id: json['id'],
      inShortcuts: json['inShortcuts'],
      intro: json['intro'],
      isCommentForbidden: json['isCommentForbidden'],
      isUserTopicAdmin: json['isUserTopicAdmin'],
      isValid: json['isValid'],
      lastMessagePostTime: json['lastMessagePostTime'],
      likeIcon: json['likeIcon'],
      operateStatus: json['operateStatus'],
      ref: json['ref'],
      squarePicture: json['squarePicture'] != null
          ? SquarePicture.fromJson(json['squarePicture'])
          : null,
      squarePostUpdateTime: json['squarePostUpdateTime'],
      subscribedStatusRawValue: json['subscribedStatusRawValue'],
      subscribersAction: json['subscribersAction'],
      subscribersCount: json['subscribersCount'],
      subscribersDescription: json['subscribersDescription'],
      subscribersName: json['subscribersName'],
      subscribersTextSuffix: json['subscribersTextSuffix'],
      tips: json['tips'] != null ? Tips.fromJson(json['tips']) : null,
      topicType: json['topicType'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['approximateSubscribersCount'] = this.approximateSubscribersCount;
    data['briefIntro'] = this.briefIntro;
    data['content'] = this.content;
    data['enablePictureComments'] = this.enablePictureComments;
    data['enablePictureWatermark'] = this.enablePictureWatermark;
    data['id'] = this.id;
    data['inShortcuts'] = this.inShortcuts;
    data['intro'] = this.intro;
    data['isCommentForbidden'] = this.isCommentForbidden;
    data['isUserTopicAdmin'] = this.isUserTopicAdmin;
    data['isValid'] = this.isValid;
    data['lastMessagePostTime'] = this.lastMessagePostTime;
    data['likeIcon'] = this.likeIcon;
    data['operateStatus'] = this.operateStatus;
    data['ref'] = this.ref;
    data['squarePostUpdateTime'] = this.squarePostUpdateTime;
    data['subscribedStatusRawValue'] = this.subscribedStatusRawValue;
    data['subscribersAction'] = this.subscribersAction;
    data['subscribersCount'] = this.subscribersCount;
    data['subscribersDescription'] = this.subscribersDescription;
    data['subscribersName'] = this.subscribersName;
    data['subscribersTextSuffix'] = this.subscribersTextSuffix;
    data['topicType'] = this.topicType;
    data['type'] = this.type;
    if (this.squarePicture != null) {
      data['squarePicture'] = this.squarePicture.toJson();
    }
    if (this.tips != null) {
      data['tips'] = this.tips.toJson();
    }
    return data;
  }
}

class Tips {
  String inComment;
  String inDraft;

  Tips({this.inComment, this.inDraft});

  factory Tips.fromJson(Map<String, dynamic> json) {
    return Tips(
      inComment: json['inComment'],
      inDraft: json['inDraft'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inComment'] = this.inComment;
    data['inDraft'] = this.inDraft;
    return data;
  }
}

class SquarePicture {
  String format;
  String middlePicUrl;
  String picUrl;
  String smallPicUrl;
  String thumbnailUrl;

  SquarePicture(
      {this.format,
      this.middlePicUrl,
      this.picUrl,
      this.smallPicUrl,
      this.thumbnailUrl});

  factory SquarePicture.fromJson(Map<String, dynamic> json) {
    return SquarePicture(
      format: json['format'],
      middlePicUrl: json['middlePicUrl'],
      picUrl: json['picUrl'],
      smallPicUrl: json['smallPicUrl'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['format'] = this.format;
    data['middlePicUrl'] = this.middlePicUrl;
    data['picUrl'] = this.picUrl;
    data['smallPicUrl'] = this.smallPicUrl;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}

class ReadTrackInfo {
  Counts counts;
  int dedupedAt;
  String feedType;
  String recallPolicy;
  String recommendReasonPolicy;
  int recommendedAt;
  String topicId;

  ReadTrackInfo(
      {this.counts,
      this.dedupedAt,
      this.feedType,
      this.recallPolicy,
      this.recommendReasonPolicy,
      this.recommendedAt,
      this.topicId});

  factory ReadTrackInfo.fromJson(Map<String, dynamic> json) {
    return ReadTrackInfo(
      counts: json['counts'] != null ? Counts.fromJson(json['counts']) : null,
      dedupedAt: json['dedupedAt'],
      feedType: json['feedType'],
      recallPolicy: json['recallPolicy'],
      recommendReasonPolicy: json['recommendReasonPolicy'],
      recommendedAt: json['recommendedAt'],
      topicId: json['topicId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dedupedAt'] = this.dedupedAt;
    data['feedType'] = this.feedType;
    data['recallPolicy'] = this.recallPolicy;
    data['recommendReasonPolicy'] = this.recommendReasonPolicy;
    data['recommendedAt'] = this.recommendedAt;
    data['topicId'] = this.topicId;
    if (this.counts != null) {
      data['counts'] = this.counts.toJson();
    }
    return data;
  }
}

class Counts {
  int click;
  int collect;
  int comment;
  int impression;
  int like;
  int repost;

  Counts(
      {this.click,
      this.collect,
      this.comment,
      this.impression,
      this.like,
      this.repost});

  factory Counts.fromJson(Map<String, dynamic> json) {
    return Counts(
      click: json['click'],
      collect: json['collect'],
      comment: json['comment'],
      impression: json['impression'],
      like: json['like'],
      repost: json['repost'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['click'] = this.click;
    data['collect'] = this.collect;
    data['comment'] = this.comment;
    data['impression'] = this.impression;
    data['like'] = this.like;
    data['repost'] = this.repost;
    return data;
  }
}

class LoadMoreKey {
  int feedTime;
  int page;
  StageKey stageKey;

  LoadMoreKey({this.feedTime, this.page, this.stageKey});

  factory LoadMoreKey.fromJson(Map<String, dynamic> json) {
    return LoadMoreKey(
      feedTime: json['feedTime'],
      page: json['page'],
      stageKey:
          json['stageKey'] != null ? StageKey.fromJson(json['stageKey']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feedTime'] = this.feedTime;
    data['page'] = this.page;
    if (this.stageKey != null) {
      data['stageKey'] = this.stageKey.toJson();
    }
    return data;
  }
}

class StageKey {
  int page;
  int stage;

  StageKey({this.page, this.stage});

  factory StageKey.fromJson(Map<String, dynamic> json) {
    return StageKey(
      page: json['page'],
      stage: json['stage'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['stage'] = this.stage;
    return data;
  }
}

class Video {
  int duration;
  int height;
  VideoImage image;
  String type;
  int width;

  Video({this.duration, this.height, this.image, this.type, this.width});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      duration: json['duration'],
      height: json['height'],
      image: json['image'] != null ? VideoImage.fromJson(json['image']) : null,
      type: json['type'],
      width: json['width'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    data['height'] = this.height;
    data['type'] = this.type;
    data['width'] = this.width;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    return data;
  }
}

class VideoImage {
  String format;
  String picUrl;
  String thumbnailUrl;

  VideoImage({this.format, this.picUrl, this.thumbnailUrl});

  factory VideoImage.fromJson(Map<String, dynamic> json) {
    return VideoImage(
      format: json['format'],
      picUrl: json['picUrl'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['format'] = this.format;
    data['picUrl'] = this.picUrl;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}
