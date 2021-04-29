import 'dart:convert';

import 'package:flutter/foundation.dart';

class ReviewModel {
  String id;
  String name;
  String photo;
  String comment;
  ReviewModel({
    @required this.id,
    @required this.name,
    @required this.photo,
    @required this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'comment': comment,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id'],
      name: map['name'],
      photo: map['photo'],
      comment: map['comment'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewModel &&
        other.id == id &&
        other.name == name &&
        other.photo == photo &&
        other.comment == comment;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ photo.hashCode ^ comment.hashCode;
  }
}
