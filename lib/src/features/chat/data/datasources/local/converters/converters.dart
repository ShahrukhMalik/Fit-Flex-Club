// Converters.dart

import 'dart:convert';

import 'package:drift/drift.dart';

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) => fromDb.split(',');

  @override
  String toSql(List<String> value) => value.join(',');
}

class StringIntMapConverter extends TypeConverter<Map<String, int>, String> {
  const StringIntMapConverter();

  @override
  Map<String, int> fromSql(String fromDb) => Map<String, int>.from(jsonDecode(fromDb));

  @override
  String toSql(Map<String, int> value) => jsonEncode(value);
}

class MemberListMapConverter extends TypeConverter<List<Map<String, String>>, String> {
  const MemberListMapConverter();

  @override
  List<Map<String, String>> fromSql(String fromDb) {
    final decoded = jsonDecode(fromDb);
    return List<Map<String, String>>.from(
      decoded.map((item) => Map<String, String>.from(item)),
    );
  }

  @override
  String toSql(List<Map<String, String>> value) {
    return jsonEncode(value);
  }
}

