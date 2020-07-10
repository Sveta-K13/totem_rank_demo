import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'Record.dart';

class Rank {
  String name;
  DateTime dateTime;
  List<Record> records;
  Rank({
    this.name,
    this.dateTime,
    this.records,
  });


  Rank copyWith({
    String name,
    DateTime dateTime,
    List<Record> records,
  }) {
    return Rank(
      name: name ?? this.name,
      dateTime: dateTime ?? this.dateTime,
      records: records ?? this.records,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'records': records?.map((x) => x?.toMap())?.toList(),
    };
  }

  static Rank fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Rank(
      name: map['name'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      records: List<Record>.from(map['records']?.map((x) => Record.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static Rank fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Rank(name: $name, dateTime: $dateTime, records: $records)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Rank &&
      o.name == name &&
      o.dateTime == dateTime &&
      listEquals(o.records, records);
  }

  @override
  int get hashCode => name.hashCode ^ dateTime.hashCode ^ records.hashCode;
}
