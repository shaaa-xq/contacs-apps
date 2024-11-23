import 'package:flutter/material.dart';
import 'package:contacs_app/database/db_helper.dart';
import 'package:contacs_app/model/kontak.dart';
import 'package:contacs_app/form_kontak.dart';

class ListKontakPage extends StatefulWidget {
  const ListKontakPage({Key? key}) : super(key: key);

  @override

  _ListKontakPageState createState() => _ListKontakPageState();
}

class _ListKontakPageState extends State<ListKontakPage> {

  List<Kontak> listKontak = [];
  DbHelper db = DbHelper();

  @override
  void initState(){
    _getAllKontak();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Contacts Apps')
        ),
      ),
      body: ListView.builder(
        itemCount: listKontak.length,
        itemBuilder: (context, index){
          Kontak kontak = listKontak[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: const BorderSide(
                color: Color(0xFFFFFFFFF),
                width: 3,
              )
            ),
            margin: EdgeInsets.only(
              left: 5,
              right: 5,
              top: 10,
            ),
            color: const Color.fromARGB(255, 248, 249, 248),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                top: 8,
                bottom: 8,
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.person,
                  size: 50,
                ),
                title: Text('${kontak.name}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text('Email: ${kontak.email}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text('Phone: ${kontak.mobileNum}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text('Company: ${kontak.company}'),
                    ),
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // edit button
                      IconButton(
                        onPressed: (){
                          _openFormEdit(kontak);
                        }, 
                        icon: const Icon(Icons.edit),
                      ),
                      // hapus button
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: (){
                          AlertDialog hapus = AlertDialog(
                            title: Text('Information'),
                            content: SizedBox(
                              height: 100,
                              child: Column(
                                children: [
                                  Text('Apakah Anda yakin ingin menghapus kontak ${'kontak.name'}?')
                                ],
                              )
                            ),
                            actions: [
                              // ya
                              TextButton(
                                onPressed: (){
                                  _deleteKontak(kontak, index);
                                  Navigator.pop(context);
                                }, 
                                child: const Text('Iya'),
                              ),
                              // tidak
                              TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                }, 
                                child: const Text('Tidak')
                              )
                            ],
                          );
                          showDialog(
                            context: context, 
                            builder: (context) => hapus
                          );
                        }, 
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
      // float button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        hoverColor: Colors.redAccent,
        child: const Icon(Icons.add),
        onPressed: (){
          _openFormCreate();
        }
      ),
    );
  }

  Future<void> _getAllKontak() async{
    var list = await db.getAllKontak();

    setState((){
      listKontak.clear();

      for(var kontak in list!){
        listKontak.add(Kontak.fromMap(kontak));
      }
    });
  }

  // get data kontak
  // delete
  Future<void> _deleteKontak(Kontak kontak, int position) async{
    await db.deleteKontak(kontak.id!);
    setState((){
      listKontak.removeAt(position);
    });
  }

  //create
  Future<void> _openFormCreate() async{
    var result = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => const FormKontak())
    );
    if (result == 'save'){
      await _getAllKontak();
    }
  }

  // edit
  Future<void> _openFormEdit(Kontak kontak) async{
    var result = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => FormKontak(kontak: kontak))
    );
    if (result == 'update'){
      await _getAllKontak();
    }
  }
}
