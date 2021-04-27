class LikeModel {
  String userid;
  bool liked;
  LikeModel({this.userid, this.liked = false});

  LikeModel.fromJson(Map<String, dynamic> json) {
    this.userid = json['id'];
    this.liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.userid;
    data['liked'] = this.liked;
    return data;
  }
}
