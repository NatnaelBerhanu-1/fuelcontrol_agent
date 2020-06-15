class Sales{
  int id;
  double litre;
  double price;
  DateTime time;
  Sales({this.id, this.litre, this.price, this.time});
}

class Invoice {
  int id;
  double litre;
  double price;
  DateTime time;
  Invoice({this.id, this.litre, this.price, this.time});
}

class Item {
  int id;
  String name;
  double price;
  String description;

  Item({this.id, this.name, this.price, this.description});

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      description: json['description']
    );
  }
}

class Driver {
  int id;
  String name;
  String email;
  String password;
  double balance;
  String status;

  Driver({this.id, this.name, this.email, this.password, this.balance,
    this.status});

  factory Driver.fromJson(Map<String, dynamic> json){
    return Driver(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        balance: double.parse(json['balance'].toString()),
        status: json['status']
    );
  }

}

class User {
  int id;
  String name;
  String email;
  String password;
  double balance;
  String status;
  double dailySale;
  double monthlySale;
  double totalSale;
  Role role;
  Department department;

  User({this.id, this.name, this.email, this.password, this.balance, this.status,
    this.role, this.department, this.totalSale, this.dailySale, this.monthlySale});

  factory User.fromJson(Map<String, dynamic> json){
    var roles = json['role'];
    var role = Role.fromJson(roles[0]);
    var dept = Department.fromJson(json['department']);
    var total = double.parse("0");
    print("total ${json['totalsale'].toString()}");
    if(json['totalsale'].toString()!="null"){
      total = double.parse(json['totalsale'].toString());
    }
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        balance: double.parse(json['balance'].toString()),
        status: json['status'],
        monthlySale: double.parse(json['monthlysale'].toString()),
        dailySale: double.parse(json['dailysale'].toString()),
        totalSale: total,
        role: role,
        department: dept,
    );
  }
}

class Department {
  int id;
  String name;
  String description;

  Department({this.id, this.name, this.description});

  factory Department.fromJson(Map<String, dynamic> json){
    return Department(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }


}

class Role {
  int id;
  String name;
  String description;

  Role({this.id, this.name, this.description});

  factory Role.fromJson(Map<String, dynamic> json){
    return Role(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

}

class PaymentRecord {
  double price;
  String type;
  String date;

  PaymentRecord({this.price, this.date, this.type});

  factory PaymentRecord.fromJson(Map<String, dynamic> json){
    return PaymentRecord(
      price: double.parse(json['price'].toString()),
      date: json['created_at'],
      type: json['type'],
    );
  }
}