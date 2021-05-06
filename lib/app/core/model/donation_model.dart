import 'dart:convert';

import 'package:flutter/foundation.dart';

class DonationModel {
  String id;
  String date;
  String person;
  String bloodtype;
  String details;
  DonationModel({
    this.id,
    @required this.date,
    @required this.person,
    @required this.bloodtype,
    @required this.details,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'person': person,
      'bloodtype': bloodtype,
      'details': details,
    };
  }

  factory DonationModel.fromMap(Map<String, dynamic> map) {
    return DonationModel(
      date: map['date'],
      person: map['person'],
      bloodtype: map['bloodtype'],
      details: map['details'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DonationModel.fromJson(String source) =>
      DonationModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DonationModel &&
        other.id == id &&
        other.date == date &&
        other.person == person &&
        other.bloodtype == bloodtype &&
        other.details == details;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        person.hashCode ^
        bloodtype.hashCode ^
        details.hashCode;
  }
}
