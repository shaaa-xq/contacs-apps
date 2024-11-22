import 'package:flutter/material.dart';
import 'package:contacs_app/database/db_helper.dart';
import 'package:contacs_app/model/kontak.dart';

class FormKontak extends StatefulWidget {
  final Kontak? kontak;
  const FormKontak({super.key, this.kontak});

  @override
  _FormKontakState createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak>{
  DbHelper db =DbHelper();

  TextEditingController? name;
  TextEditingController? lastName;
  TextEditingController? mobileNum;
  TextEditingController? email;
  TextEditingController? company;

  @override
  void initState(){
    name = TextEditingController(
      text: widget.kontak == null ? '' : widget.kontak!.name
    );
    mobileNum = TextEditingController(
      text: widget.kontak == null ? '' : widget.kontak!.mobileNum
    );
    email = TextEditingController(
      text: widget.kontak == null ? '' : widget.kontak!.email
    );
    company = TextEditingController(
      text: widget.kontak == null ? '' : widget.kontak!.company
    );
    super.initState();
  }



}