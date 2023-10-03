import 'dart:convert';
/// adhar : "123456789123"
/// email : "gutka_dhari_nagin@gmail.com"
/// empid : "qer"
/// firstname : "gutka"
/// lastname : "dhari nagin"
/// mobile : "1478523690"
/// password : "pbkdf2:sha256:600000$H8A2frejn8xHnOi8$2304ee4f79bcc9e77786f88d6d05eb0fc360d94eb7352b6d78423d1897bfbdcf"
/// role : "Advocate"
/// total : "100"
/// win_percentage : "69"
/// wins : "69"

Lawyers lawyersFromJson(String str) => Lawyers.fromJson(json.decode(str));
String lawyersToJson(Lawyers data) => json.encode(data.toJson());
class Lawyers {
  Lawyers({
      String? adhar, 
      String? email, 
      String? empid, 
      String? firstname, 
      String? lastname, 
      String? mobile, 
      String? password, 
      String? role, 
      String? total, 
      String? winPercentage, 
      String? wins,}){
    _adhar = adhar;
    _email = email;
    _empid = empid;
    _firstname = firstname;
    _lastname = lastname;
    _mobile = mobile;
    _password = password;
    _role = role;
    _total = total;
    _winPercentage = winPercentage;
    _wins = wins;
}

  Lawyers.fromJson(dynamic json) {
    _adhar = json['adhar'];
    _email = json['email'];
    _empid = json['empid'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _mobile = json['mobile'];
    _password = json['password'];
    _role = json['role'];
    _total = json['total'];
    _winPercentage = json['win_percentage'];
    _wins = json['wins'];
  }
  String? _adhar;
  String? _email;
  String? _empid;
  String? _firstname;
  String? _lastname;
  String? _mobile;
  String? _password;
  String? _role;
  String? _total;
  String? _winPercentage;
  String? _wins;
Lawyers copyWith({  String? adhar,
  String? email,
  String? empid,
  String? firstname,
  String? lastname,
  String? mobile,
  String? password,
  String? role,
  String? total,
  String? winPercentage,
  String? wins,
}) => Lawyers(  adhar: adhar ?? _adhar,
  email: email ?? _email,
  empid: empid ?? _empid,
  firstname: firstname ?? _firstname,
  lastname: lastname ?? _lastname,
  mobile: mobile ?? _mobile,
  password: password ?? _password,
  role: role ?? _role,
  total: total ?? _total,
  winPercentage: winPercentage ?? _winPercentage,
  wins: wins ?? _wins,
);
  String? get adhar => _adhar;
  String? get email => _email;
  String? get empid => _empid;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get mobile => _mobile;
  String? get password => _password;
  String? get role => _role;
  String? get total => _total;
  String? get winPercentage => _winPercentage;
  String? get wins => _wins;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adhar'] = _adhar;
    map['email'] = _email;
    map['empid'] = _empid;
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    map['mobile'] = _mobile;
    map['password'] = _password;
    map['role'] = _role;
    map['total'] = _total;
    map['win_percentage'] = _winPercentage;
    map['wins'] = _wins;
    return map;
  }

}