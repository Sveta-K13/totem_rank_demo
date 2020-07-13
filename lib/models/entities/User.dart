import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'Rank.dart';

class User {
  String name;
  List<Rank> ranks;
  User({
    this.name,
    this.ranks,
  });

  User copyWith({
    String name,
    List<Rank> ranks,
  }) {
    return User(
      name: name ?? this.name,
      ranks: ranks ?? this.ranks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ranks': ranks?.map((x) => x?.toMap())?.toList(),
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return User(
      name: map['name'],
      ranks: List<Rank>.from(map['ranks']?.map((x) => Rank.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap()); // throw exceptions if need

  static User fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'User(name: $name, ranks: $ranks)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is User &&
      o.name == name &&
      listEquals(o.ranks, ranks);
  }

  @override
  int get hashCode => name.hashCode ^ ranks.hashCode;
}
