import 'package:flutter/material.dart';
import 'package:healthnut/pages/login.dart';
import 'package:healthnut/services/auth_service.dart';
import 'package:healthnut/shared/loading.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Home'),
            ),
            body: ElevatedButton(
              onPressed: () {
                context.read<AuthenticationProvider>().signOut().then((value) {
                  setState(() {
                    loading = true;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  ).then((value) {
                    setState(() {
                      loading = false;
                    });
                  });
                });
              },
              child: const Text('Logout'),
            ),
          );
  }
}
