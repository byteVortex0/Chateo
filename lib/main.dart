import 'package:chateo/chateo.dart';
import 'package:chateo/core/app/env_variables.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/di/injection.dart';
import 'core/service/shared_pref/shared_pref.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();
  await EnvVariables().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Supabase.initialize(
    url: EnvVariables().supabaseUrl,
    anonKey: EnvVariables().supabaseAnonKey,
  );

  await SharedPref.init();

  await setupInjection();

  runApp(const Chateo());
}
