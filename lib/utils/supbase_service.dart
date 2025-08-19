import 'dart:developer';
import 'package:mahmoudbakir_portfolio/const/private_string.dart';
import 'package:supabase/supabase.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  late final SupabaseClient _client;
  bool _isInitialized = false;

  void initSupabase() {
    if (!_isInitialized) {
      _client = SupabaseClient(supabaseUrl, anonKey);
      _isInitialized = true;
    }
  }

  SupabaseClient get client {
    if (!_isInitialized) {
      throw Exception(
        'SupabaseService not initialized. Call initSupabase() first.',
      );
    }
    return _client;
  }

  // --- جلب بيانات المستخدم ---
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final response = await _client
          .from('portfolio_data')
          .select('*')
          .limit(1);
      return response.isNotEmpty ? response[0] : null;
    } catch (e) {
      log('Error fetching user data: $e');
      throw Exception('Failed to fetch user data: $e');
    }
  }

  // --- جلب المشاريع ---
  Future<List<Map<String, dynamic>>> getProjects() async {
    try {
      return await _client
          .from('projects')
          .select(
            'id, title, description, technologies, github_url, live_url, '
            'main_image_url, gallery_image_urls, created_at, updated_at',
          )
          .order('created_at', ascending: false);
    } catch (e) {
      throw Exception('Failed to fetch projects: $e');
    }
  }

  // --- جلب المهارات ---
  Future<List<String>> getSkills() async {
    try {
      final response = await _client
          .from('skills')
          .select('skill_name')
          .order('created_at', ascending: false);
      return response.map((s) => s['skill_name'] as String).toList();
    } catch (e) {
      throw Exception('Failed to fetch skills: $e');
    }
  }

  // --- جلب اللغات ---
  Future<List<Map<String, dynamic>>> getSpokenLanguages() async {
    try {
      final response = await _client
          .from('spoken_languages')
          .select('language_name, proficiency, is_selected')
          .order('created_at', ascending: false);

      return response
          .map(
            (lang) => {
              'name': lang['language_name'] as String,
              'proficiency': lang['proficiency'] as int,
              'isSelected': lang['is_selected'] as bool,
            },
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch spoken languages: $e');
    }
  }

  // --- حفظ رسالة تواصل ---
  Future<void> saveContactMessage({
    required String name,
    required String email,
    required String message,
    String? subject,
  }) async {
    try {
      await _client.from('contact_messages').insert({
        'name': name,
        'email': email,
        'subject': subject,
        'message': message,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to save contact message: $e');
    }
  }

  Future<Map<String, dynamic>?> getLatestCv() async {
    try {
      final response = await _client
          .from('cv_files')
          .select('file_name, file_url, uploaded_at')
          .order('uploaded_at', ascending: false)
          .limit(1);

      if (response.isEmpty) return null;
      return response[0];
    } on PostgrestException catch (e) {
      log('Database error fetching CV: ${e.message}');
      return null;
    } catch (e) {
      log('Unexpected error fetching CV: $e');
      return null;
    }
  }

  Future<String?> getCvUrl() async {
    final cv = await getLatestCv();
    return cv?['file_url'] as String?;
  }
}
