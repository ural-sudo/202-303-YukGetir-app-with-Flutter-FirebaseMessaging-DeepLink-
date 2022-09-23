
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:yuk_getir/Screens/anasayfa.dart';

import 'Screens/deneme_page.dart';

Future<void> main() async {
  /* await getToken(); */
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Yük Getir',
      /* navigatorKey: Grock.navigationKey,
      scaffoldMessengerKey: Grock.scaffoldMessengerKey, */
      theme: ThemeData(
        appBarTheme:const  AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0
        ),
        colorScheme:const  ColorScheme(
          brightness: Brightness.dark,
          primary:Color.fromARGB(196, 4, 85, 167),
          onPrimary:Color.fromARGB(196, 4, 85, 167),
          secondary: Color.fromARGB(255, 246, 150, 24),
          onSecondary:Colors.orangeAccent,
          error: Colors.red,
          onError: Colors.red,
          background: Color.fromARGB(255, 152, 149, 149),
          onBackground: Color.fromARGB(255, 15, 15, 15),
          surface: Colors.white,
          onSurface: Colors.white

        ),
        scaffoldBackgroundColor:const  Color.fromARGB(255, 240, 241, 248)
      ),
      home:const Anasayfa(),
    );
  }
}

