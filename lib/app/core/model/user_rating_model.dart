import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserRatingModel {
  String docId;
  // final String userId;
  int star;
  UserRatingModel({
    this.docId,
    @required this.star,
  });

  Map<String, dynamic> toMap() {
    return {
      'star': star,
    };
  }

  factory UserRatingModel.fromMap(Map<String, dynamic> map) {
    return UserRatingModel(
      star: map['star'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRatingModel.fromJson(String source) =>
      UserRatingModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserRatingModel && other.star == star;
  }

  @override
  int get hashCode => star.hashCode;
}
