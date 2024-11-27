import 'package:contacs_app/database/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:contacs_app/list_kontak.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  await DbHelper();
  runApp(const ContactsApp());

  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;

  runApp(ContactsApp());
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