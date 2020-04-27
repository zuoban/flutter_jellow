/**
    {
      "accessToken":"",
      "refreshToken":"",
      "clientRequestId": "",
    }
*/
class UserProfile {
  String accessToken;
  String clientRequestId;
  String refreshToken;

  UserProfile({this.accessToken, this.clientRequestId, this.refreshToken});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      accessToken: json['accessToken'],
      clientRequestId: json['clientRequestId'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['clientRequestId'] = this.clientRequestId;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
