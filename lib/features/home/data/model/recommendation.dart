// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Recommendation {
  final String id;
  final String result;
  final String createdAt;
  Recommendation({
    required this.id,
    required this.result,
    required this.createdAt,
  });

  Recommendation copyWith({
    String? id,
    String? result,
    String? createdAt,
  }) {
    return Recommendation(
      id: id ?? this.id,
      result: result ?? this.result,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'result': result,
      'createdAt': createdAt,
    };
  }

  factory Recommendation.fromMap(Map<String, dynamic> map) {
    return Recommendation(
      id: map['id'] as String,
      result: map['result'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Recommendation.fromJson(String source) =>
      Recommendation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Recommendation(id: $id, result: $result, createdAt: $createdAt)';

  @override
  bool operator ==(covariant Recommendation other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.result == result &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ result.hashCode ^ createdAt.hashCode;
}
