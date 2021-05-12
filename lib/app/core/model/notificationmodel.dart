class NotificationData {
  String id;
  String title;
  String message;
 // String imgpath;
  String noticedate;
  bool noticeRead;
  //final String payload;

  NotificationData({
    this.title,
    this.message,
  //  this.imgpath,
    this.noticedate,
    this.noticeRead,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
    //  'imgpath': imgpath,
      'noticedate': noticedate,
      'noticeRead': noticeRead,
      // 'payload': payload,
    };
  }
}
