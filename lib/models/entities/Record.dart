import 'dart:convert';

class Record {
  int id;
  final String name;

  Record({
    this.id,
    this.name,
  }) {
    if (this.id == null) {
      this.id = DateTime.now().millisecondsSinceEpoch;
    }
  }

  Record copyWith({
    String name,
    int id,
  }) {
    return Record(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }

  static Record fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Record(
      name: map['name'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  static Record fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Record(name: $name, id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Record &&
      o.name == name &&
      o.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
