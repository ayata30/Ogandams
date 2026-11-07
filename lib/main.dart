import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // prepares fluuter before the async call happens
  WidgetsFlutterBinding.ensureInitialized();
  // establish firebase connection
  await Firebase.initializeApp(
    // slects the platform teh app is runnig on
    options: DefaultFirebaseOptions.currentPlatform,
  );
//starts the app after firebase is ready
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ogandams',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue,
      ),
      useMaterial3: true,
      ),

      home: const MyHomePage(title: 'Ogandams'),

    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child:
          Text('Firebase initlialized succesfully'),

        ),
    );
  }
}
