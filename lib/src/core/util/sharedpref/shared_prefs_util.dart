import 'dart:convert';
import 'package:fit_flex_club/src/features/authentication/domain/entities/auth_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
@singleton
class SharedPrefsUtil {
  static const String _keyAuthUid = 'auth_uid';
  static const String _keyAuthEntity = 'auth_entity';
  static const String _keyLastUpdateTimestamp = 'last_update_timestamp';
  
  final SharedPreferences _prefs;

  // Constructor injection
  SharedPrefsUtil(this._prefs);

  // Auth UID methods with timestamp
  Future<bool> setAuthUid(String uid) async {
    await _updateLastTimestamp();
    return await _prefs.setString(_keyAuthUid, uid);
  }

  String? getAuthUid() {
    return _prefs.getString(_keyAuthUid);
  }

  Future<bool> removeAuthUid() async {
    return await _prefs.remove(_keyAuthUid);
  }

  // Auth Entity methods with timestamp
  Future<bool> setAuthEntity(AuthEntity authEntity) async {
    final jsonString = json.encode(authEntity.toJson());
    await _updateLastTimestamp();
    return await _prefs.setString(_keyAuthEntity, jsonString);
  }

  AuthEntity? getAuthEntity() {
    final jsonString = _prefs.getString(_keyAuthEntity);
    if (jsonString == null) return null;
    
    try {
      final jsonMap = json.decode(jsonString);
      return AuthEntity.fromJson(jsonMap);
    } catch (e) {
      print('Error parsing AuthEntity: $e');
      return null;
    }
  }

  Future<bool> removeAuthEntity() async {
    return await _prefs.remove(_keyAuthEntity);
  }

  // Timestamp management
  Future<void> _updateLastTimestamp() async {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    await _prefs.setInt(_keyLastUpdateTimestamp, currentTime);
  }

  DateTime? _getLastUpdateTime() {
    final timestamp = _prefs.getInt(_keyLastUpdateTimestamp);
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  // Check if data is stale (older than specified duration)
  bool isDataStale({Duration threshold = const Duration(days: 1)}) {
    final lastUpdate = _getLastUpdateTime();
    if (lastUpdate == null) return true;

    final currentTime = DateTime.now();
    final difference = currentTime.difference(lastUpdate);
    
    return difference > threshold;
  }

  // Clear all auth related data
  Future<void> clearAuthData() async {
    await Future.wait([
      removeAuthUid(),
      removeAuthEntity(),
      _prefs.remove(_keyLastUpdateTimestamp),
    ]);
  }

  // Check if user is authenticated and data is fresh
  bool isAuthenticated({bool checkFreshness = true}) {
    final authEntity = getAuthEntity();
    final authUid = getAuthUid();
    
    if (authEntity == null || authUid == null) return false;
    
    if (checkFreshness && isDataStale()) {
      return false;
    }
    
    return true;
  }

  // Get data age in hours (useful for debugging or UI feedback)
  double? getDataAgeInHours() {
    final lastUpdate = _getLastUpdateTime();
    if (lastUpdate == null) return null;

    final currentTime = DateTime.now();
    final difference = currentTime.difference(lastUpdate);
    
    return difference.inMinutes / 60;
  }
}