import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ruztnslthjorojrvywcd.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ1enRuc2x0aGpvcm9qcnZ5d2NkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg4MTgyNzksImV4cCI6MjA4NDM5NDI3OX0.JkFofne2HDfTZacMmBIqRGlGju0ngcTntQgf3bhyQEw',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(), // 👈 ECCO LA TUA PRIMA PAGINA
    );
  }
}
