// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TipsModel {
  final String? title;
  final String? point;
  const TipsModel({
    this.title,
    this.point,
  });

  TipsModel copyWith({
    String? title,
    String? point,
  }) {
    return TipsModel(
      title: title ?? this.title,
      point: point ?? this.point,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'point': point,
    };
  }

  factory TipsModel.fromMap(Map<String, dynamic> map) {
    return TipsModel(
      title: map['title'] ?? '',
      point: map['point'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TipsModel.fromJson(String source) =>
      TipsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TipsModel(title: $title, point: $point)';

  @override
  bool operator ==(covariant TipsModel other) {
    if (identical(this, other)) return true;

    return other.title == title && other.point == point;
  }

  @override
  int get hashCode => title.hashCode ^ point.hashCode;
}
