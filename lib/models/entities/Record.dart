import 'dart:convert';

class Record {
  final String name;
  Record({
    this.name,
  });

  Record copyWith({
    String name,
  }) {
    return Record(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  static Record fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Record(
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  static Record fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Record(name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Record &&
      o.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
