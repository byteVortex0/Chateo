import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVariables {
  EnvVariables._();

  static final EnvVariables instance = EnvVariables._();

  factory EnvVariables() => instance;

  String _supabaseUrl = '';
  String _supabaseAnonKey = '';

  Future<void> init() async {
    await dotenv.load(fileName: '.env.dev');

    _supabaseUrl = dotenv.get('SUPABASE_URL');
    _supabaseAnonKey = dotenv.get('SUPABASE_ANON_KEY');
  }

  String get supabaseUrl => _supabaseUrl;
  String get supabaseAnonKey => _supabaseAnonKey;
}
