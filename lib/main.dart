import 'package:adivinhe_o_numero/play_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adivinhe o número',
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const PlayView(),
    );
  }
}
