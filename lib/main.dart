
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:legal_ease/auth/login_page.dart';
import 'package:legal_ease/providers/user_provider.dart';
import 'package:legal_ease/splashscreen2.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
    
          theme: ThemeData(
         
            
            brightness: Brightness.dark,
          ),
          home:  splashscreen2(),
  )
          
    );
  }
}
