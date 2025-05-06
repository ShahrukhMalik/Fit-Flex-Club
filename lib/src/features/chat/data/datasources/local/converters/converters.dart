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
  Map<String, int> fromSql(String fromDb) =>
      Map<String, int>.from(jsonDecode(fromDb));

  @override
  String toSql(Map<String, int> value) => jsonEncode(value);
}

class StringMapConverter extends TypeConverter<Map<String, dynamic>, String> {
  const StringMapConverter();

  @override
  Map<String, dynamic> fromSql(String fromDb) => Map<String, dynamic>.from(
        jsonDecode(fromDb),
      );

  @override
  String toSql(Map<String, dynamic> value) => jsonEncode(value);
}

class MemberListMapConverter
    extends TypeConverter<List<Map<String, dynamic>>, String> {
  const MemberListMapConverter();

  @override
  List<Map<String, dynamic>> fromSql(String fromDb) {
    final decoded = jsonDecode(fromDb);
    return List<Map<String, dynamic>>.from(
      decoded.map((item) => Map<String, dynamic>.from(item)),
    );
  }

  @override
  String toSql(List<Map<String, dynamic>> value) {
    return jsonEncode(value);
  }
}
