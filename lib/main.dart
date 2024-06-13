import 'package:flutter/material.dart';

import 'leads/leads_page.dart';

void main() {
  runApp(const APIDemo());
}

class APIDemo extends StatelessWidget {
  const APIDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LeadsPage(title: 'API Demo'),
    );
  }
}