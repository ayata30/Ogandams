
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../screens/request_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ogandams'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RequestScreen(),
                ),
              );
            },
            child: const Text('Request Support'),
          ),
          ),
    );
  }
}
