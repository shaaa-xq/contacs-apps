import 'package:flutter/material.dart';
import 'package:contacs_app/list_kontak.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;

void main() {
  runApp(const ContactsApp());

  sqflite_ffi.sqfliteFfiInit();
}

class ContactsApp extends StatelessWidget {
  const ContactsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacs Apps',
      theme: ThemeData(
        useMaterial3: false, 
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red
        ),
      ),
      home: const ListKontakPage(),
    );
  }
}