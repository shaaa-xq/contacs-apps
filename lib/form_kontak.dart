import 'package:flutter/material.dart';
import 'package:contacs_app/database/db_helper.dart';
import 'package:contacs_app/model/kontak.dart';
import 'package:path/path.dart';

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

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Form'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // form name
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          // form number
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: mobileNum,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          // form email
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          
          // form company
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: company,
              decoration: InputDecoration(
                labelText: 'Company',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          // button
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                child: (widget.kontak == null)
                ? const Text(
                  'Add', 
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                )
                : const Text(
                  'Update',
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
                onPressed: (){
                  upsertKontak();
                }, 
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertKontak() async{
  if (widget.kontak != null){
    
    // update
    await db.updateKontak(Kontak.fromMap({
      'id': widget.kontak!.id,
      'name': name!.text,
      'mobileNum': mobileNum!.text,
      'email': email!.text,
      'company': company!.text,
    }));
    Navigator.pop(context as BuildContext, 'update');
  } else{

    // create
    await db.saveKontak(Kontak.fromMap({
      'name': name!.text,
      'mobileNum': mobileNum!.text,
      'email': email!.text,
      'company': company!.text,
    }));
    Navigator.pop(context as BuildContext, 'save');
    }
  }
}

