import 'dart:convert';


class CommentModel {
  String id;
  String name;
  String photo;
  String comment;

  String timestamp;
  CommentModel({
    this.id,
    this.name,
    this.photo,
    this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'comment': comment,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'],
      name: map['name'],
      photo: map['photo'],
      comment: map['comment'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentModel &&
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
