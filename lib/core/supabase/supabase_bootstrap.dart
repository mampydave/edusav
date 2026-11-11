import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/supabase_config.dart';

class SupabaseBootstrap {
  const SupabaseBootstrap._();

  static Future<bool> initialize() async {
    if (!SupabaseConfig.isConfigured) return false;

    await Supabase.initialize(
      url: SupabaseConfig.url,
      publishableKey: SupabaseConfig.publishableKey,
    );
    return true;
  }
}
