class LikeModel {
  String userid;
  String postid;
  bool liked;
  LikeModel({this.userid, this.postid,this.liked});

  LikeModel.fromJson(Map<String, dynamic> json) {
    this.userid = json['id'];
    this.postid = json['postid'];
    this.liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['postid'] = this.postid;
    data['liked'] = this.liked;
    return data;
  }
}
