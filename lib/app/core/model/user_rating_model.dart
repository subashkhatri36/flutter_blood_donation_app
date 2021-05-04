import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserRatingModel {
  String docId;
  final String userId;
  int star;
  UserRatingModel({
    this.docId,
    @required this.userId,
    @required this.star,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'star': star,
    };
  }

  factory UserRatingModel.fromMap(Map<String, dynamic> map) {
    return UserRatingModel(
      userId: map['userId'],
      star: map['star'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRatingModel.fromJson(String source) =>
      UserRatingModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserRatingModel &&
        other.userId == userId &&
        other.star == star;
  }

  @override
  int get hashCode => userId.hashCode ^ star.hashCode;
}
