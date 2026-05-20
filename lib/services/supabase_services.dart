import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final client = Supabase.instance.client;
  // =========================
  // SCRIMS
  // =========================

  static Future<List<Map<String, dynamic>>> getScrims() async {
    final response = await client
        .from('scrims')
        .select();

    return List<Map<String, dynamic>>.from(response);
  }

  // =========================
  // SCRIM SESSIONS
  // =========================

  static Future<List<Map<String, dynamic>>> getSessionsByScrim(
      String scrimId) async {
    final response = await client
        .from('scrim_sessions')
        .select()
        .eq('scrim_id', scrimId)
        .order('start_time');
return List<Map<String, dynamic>>.from(response);
  }

  // =========================
  // BOOKINGS
  // =========================

  static Future<void> createBooking({
    required String sessionId,
    required String teamName,
    required String captainFFId,
    required String whatsapp,
    required List<String> members,
    required String paymentMethod,
  }) async {
    final user = client.auth.currentUser;

    if (user == null) {
      throw Exception('User belum login');
    }
    await client.from('bookings').insert({
      'session_id': sessionId,
      'user_id': user.id,
      'team_name': teamName,
      'captain_ff_id': captainFFId,
      'whatsapp_number': whatsapp,
      'team_members': members,
      'payment_method': paymentMethod,
      'payment_status': 'pending',
    });
  }

  // =========================
  // PROFILE
  // =========================

  static Future<Map<String, dynamic>?> getMyProfile() async {
    final user = client.auth.currentUser;

    if (user == null) return null;

    final response = await client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

    return response;
  }
}