import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVariables {
  EnvVariables._();

  static final EnvVariables instance = EnvVariables._();

  factory EnvVariables() => instance;

  String _supabaseUrl = '';
  String _supabaseAnonKey = '';
  String _privateKeyId = '';
  String _privateKey = '';

  Future<void> init() async {
    await dotenv.load(fileName: '.env.dev');

    _supabaseUrl = dotenv.get('SUPABASE_URL');
    _supabaseAnonKey = dotenv.get('SUPABASE_ANON_KEY');
    _privateKeyId = dotenv.get('PRIVATE_KEY_ID');
    _privateKey = dotenv.get('PRIVATE_KEY');
  }

  String get supabaseUrl => _supabaseUrl;
  String get supabaseAnonKey => _supabaseAnonKey;
  String get privateKeyId => _privateKeyId;
  String get privateKey => _privateKey;
}
