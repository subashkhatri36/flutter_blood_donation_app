import 'dart:convert';

import 'package:flutter/foundation.dart';

class LikeModel {
  String postId;
  String docId;
  LikeModel({
    @required this.postId,
    @required this.docId,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': postId,
      'docId': docId,
    };
  }

  factory LikeModel.fromMap(Map<String, dynamic> map) {
    return LikeModel(
      postId: map['userId'],
      docId: map['docId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LikeModel.fromJson(String source) =>
      LikeModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LikeModel && other.postId == postId && other.docId == docId;
  }

  @override
  int get hashCode => postId.hashCode ^ docId.hashCode;
}
