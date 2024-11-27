class Kontak{
  int? id;
  String? name;
  String? mobileNum;
  String? email;
  String? company;
  
  Kontak({
    this.id,
    this.name,
    this.mobileNum,
    this.email,
    this.company,
  });

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{};

    if (id != null){
      map['id'] = id;
    }

    map['name'] = name;
    map['mobileNum'] = mobileNum;
    map['email'] = email;
    map['company'] = company;

    return map;
  }

  Kontak.fromMap(Map<String, dynamic> map){
    id = map['id'];
    name = map['name'];
    mobileNum = map['mobileNum'];
    email = map['email'];
    company = map['company'];
  }
}

