import 'dart:developer';
import 'package:file_selector/file_selector.dart'; // ✅ يدعم web & mobile
import 'package:flutter/material.dart';
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

  // --- التحقق من الصورة (يعمل على الويب) ---
  Future<void> _validateImage(XFile imageFile) async {
    final name = imageFile.name.toLowerCase();
    if (!['.jpg', '.jpeg', '.png'].any((ext) => name.endsWith(ext))) {
      throw Exception('Only JPG/JPEG/PNG images are allowed');
    }

    final int length = await imageFile.length();
    const maxSize = 5 * 1024 * 1024; // 5MB
    if (length > maxSize) {
      throw Exception('Image size must be less than 5MB');
    }
  }

  // --- حذف الصورة القديمة ---
  Future<void> _deleteOldImage(String imageUrl) async {
    try {
      final path = imageUrl.split('/profile-images/').last;
      await _client.storage.from('profile-images').remove([path]);
    } catch (e) {
      log('Warning: Could not delete old image: $e');
    }
  }

  // --- رفع الصورة ---
  Future<String?> _uploadImage(XFile imageFile, String folder) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final name = imageFile.name;
      final cleanedName = name.replaceAll(RegExp(r'[^a-zA-Z0-9\-_.]'), '_');
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_$cleanedName';
      final filePath = '$folder$fileName';

      await _client.storage
          .from('profile-images')
          .uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(
              contentType: imageFile.mimeType ?? 'image/jpeg',
              cacheControl: '3600',
              upsert: true,
            ),
          );

      return _client.storage.from('profile-images').getPublicUrl(filePath);
    } catch (e) {
      log('Error uploading image: $e');
      throw Exception('Failed to upload image: ${e.toString()}');
    }
  }

  // --- حفظ بيانات المستخدم ---
  Future<void> saveUserData({
    required String name,
    required String profession,
    required String bio,
    required String email,
    required String phone,
    required String location,
    XFile? profileImage,
  }) async {
    try {
      String? imageUrl;
      if (profileImage != null) {
        await _validateImage(profileImage);
        imageUrl = await _uploadImage(profileImage, 'profile-images/');
      }

      final existingData = await _client
          .from('portfolio_data')
          .select('id, profile_image_url')
          .limit(1);

      if (profileImage != null &&
          existingData.isNotEmpty &&
          existingData[0]['profile_image_url'] != null) {
        await _deleteOldImage(existingData[0]['profile_image_url'] as String);
      }

      final data = {
        'name': name,
        'profession': profession,
        'bio': bio,
        'email': email,
        'phone': phone,
        'location': location,
        'profile_image_url': imageUrl,
        'updated_at': DateTime.now().toIso8601String(),
      };

      if (existingData.isNotEmpty && existingData[0].containsKey('id')) {
        await _client
            .from('portfolio_data')
            .update(data)
            .eq('id', existingData[0]['id']);
      } else {
        await _client.from('portfolio_data').insert(data);
      }
    } catch (e) {
      log('Error saving user data: $e');
      throw Exception('Failed to save user data: ${e.toString()}');
    }
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

  // --- حفظ المشاريع ---
  Future<void> saveProject({
    required String title,
    required String description,
    required List<String> technologies,
    String? githubUrl,
    String? liveUrl,
    XFile? mainImage,
    List<XFile> galleryImages = const [],
  }) async {
    try {
      String? mainImageUrl;
      List<String> galleryUrls = [];

      if (mainImage != null) {
        mainImageUrl = await _uploadImageToProjectBucket(mainImage, 'main');
      }

      for (var image in galleryImages) {
        final url = await _uploadImageToProjectBucket(image, 'gallery');
        galleryUrls.add(url);
      }

      await _client.from('projects').insert({
        'title': title,
        'description': description,
        'technologies': technologies,
        'github_url': githubUrl,
        'live_url': liveUrl,
        'main_image_url': mainImageUrl,
        'gallery_image_urls': galleryUrls,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to save project: $e');
    }
  }

  // --- رفع صورة المشروع ---
  Future<String> _uploadImageToProjectBucket(
    XFile file,
    String subfolder,
  ) async {
    try {
      final bytes = await file.readAsBytes();
      final fileName =
          'img_${DateTime.now().millisecondsSinceEpoch}_${file.name}';
      final filePath = 'projects/$subfolder/$fileName';

      await _client.storage
          .from('project-images')
          .uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(upsert: true),
          );

      return _client.storage.from('project-images').getPublicUrl(filePath);
    } catch (e) {
      throw Exception('Failed to upload project image: $e');
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

  // --- حفظ المهارات ---
  Future<void> saveSkills(List<String> skills) async {
    try {
      await _client.from('skills').delete().neq('skill_name', '');

      if (skills.isNotEmpty) {
        final skillsData = skills
            .toSet()
            .map(
              (skill) => {
                'skill_name': skill,
                'created_at': DateTime.now().toIso8601String(),
              },
            )
            .toList();

        await _client.from('skills').insert(skillsData);
      }
    } catch (e) {
      throw Exception('Failed to save skills: $e');
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

  // --- حفظ اللغات ---
  Future<void> saveSpokenLanguages(List<Map<String, dynamic>> languages) async {
    try {
      await _client.from('spoken_languages').delete().neq('language_name', '');

      if (languages.isNotEmpty) {
        final data = languages
            .map(
              (lang) => {
                'language_name': lang['name'],
                'proficiency': lang['proficiency'] is double
                    ? lang['proficiency'].toInt()
                    : lang['proficiency'],
                'is_selected': lang['isSelected'] ?? true,
                'created_at': DateTime.now().toIso8601String(),
              },
            )
            .toList();

        await _client.from('spoken_languages').insert(data);
      }
    } catch (e) {
      throw Exception('Failed to save spoken languages: $e');
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

  // --- حذف مشروع ---
  Future<void> deleteProject(int id) async {
    try {
      await _client.from('projects').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete project: $e');
    }
  }
}
