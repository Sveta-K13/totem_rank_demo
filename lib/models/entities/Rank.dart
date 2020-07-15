import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'Record.dart';

class Rank {
  int id;
  String name;
  DateTime dateTime;
  List<Record> records;
  Rank({
    this.id,
    this.name,
    this.dateTime,
    this.records,
  }) {
    if (this.id == null) {
      this.id = DateTime.now().millisecondsSinceEpoch;
    }
    if (this.dateTime == null) {
      this.dateTime = DateTime.now();
    }
  }


  Rank copyWith({
    int id,
    String name,
    DateTime dateTime,
    List<Record> records,
  }) {
    return Rank(
      id: id ?? this.id,
      name: name ?? this.name,
      dateTime: dateTime ?? this.dateTime,
      records: records ?? this.records,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'records': records?.map((x) => x?.toMap())?.toList(),
    };
  }

  static Rank fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Rank(
      id: map['id'],
      name: map['name'],
      dateTime: map['dateTime'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateTime']) : DateTime.now(),
      records: List<Record>.from(map['records']?.map((x) => Record.fromMap(x as Map<String, dynamic>))),
    );
  }

  String toJson() => json.encode(toMap());

  static Rank fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Rank(id: $id, name: $name, dateTime: $dateTime, records: $records)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Rank &&
      o.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
