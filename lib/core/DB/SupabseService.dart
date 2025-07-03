import 'package:chat75/core/DB/dbService.dart';
import 'package:gotrue/src/types/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabseService implements DbService {
  @override
  SupabaseClient get client => Supabase.instance.client;

  @override
  Future<User?> sigIn(String email, String password) async {
    try {
      final response = await client.auth
          .signInWithPassword(email: email, password: password);
      return response.user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await client.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> signUp(String email, String password) async {
    try {
      final response =
          await client.auth.signUp(email: email, password: password);
      return response.user;
    } catch (e) {
      rethrow;
    }
  }

  String? get CurrentUserId {
    return client.auth.currentUser!.id;
  }

  @override
  Future<void> insert(String table, Map<String, dynamic> data) async {
    try {
      await client.from(table).insert(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllDatabyFilterNeq(
      String table, String column, String value) async {
    try {
      final response = await client.from(table).select().neq(column, value);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
