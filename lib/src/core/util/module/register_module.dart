import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drift/native.dart';

@module
abstract class RegisterModule {
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker();
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  // http.Client get httpClient => http.Client();
  FirebaseAuth get auth => FirebaseAuth.instance;
  FirebaseFirestore get db => FirebaseFirestore.instance;
  @singleton
  AppDatabase get localDb => AppDatabase();
  // FirebaseStorage get storage => FirebaseStorage.instance;
}
