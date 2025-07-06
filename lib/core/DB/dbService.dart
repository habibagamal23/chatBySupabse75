import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class DbService {
  dynamic get client;

  Future<dynamic> signUp(String email, String password);

  Future<User?> sigIn(String email, String password);

  Future<void> signOut();

  Future<void> insert(String table, Map<String, dynamic> data);

  Future<List<Map<String, dynamic>>> fetchAllDatabyFilterNeq(String table,
      String column, String value);

  Future<List<Map<String, dynamic>>> getAllData(String table);

  Future<Map<String, dynamic>> getSingleData(String table, String column,
      String value);

  Future<void> upadte(String table, Map<String, dynamic> data, String column,String value);

}
