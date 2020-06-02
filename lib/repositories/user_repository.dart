import 'dart:convert';

import 'package:fuelcontrolseller/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const baseUrl = 'http://192.168.1.2:8000/api/v1/';

class UserRepository {
  final Future<SharedPreferences> preferences;
  User loggedInUser;
  List<PaymentRecord> paymentRecords;
  UserRepository({this.preferences});

  Future<bool> login(User user) async{
    print('login agent');
    final SharedPreferences prefs = await preferences;
    try{
      print('login try');
      var response = await http.post(baseUrl+'login', body: {'email': user.email, 'password': user.password, 'filter': 'fuelagent'}).timeout(Duration(seconds: 10));
      print(response.body);

      if(response.statusCode == 200){
        User usr = User.fromJson(json.decode(response.body)['data']);
        print(usr.role.name);
        if(usr.role.name == 'fuelagent'){
          prefs.setString('loggedIn', 'true');
          prefs.setString('loggedInEmail', usr.email);
          loggedInUser = usr;
          return true;
        }
        return false;
      }else {
        return false;
      }
    }catch(e){
      print(e);
      print("error here");
      return false;
    }
  }

  Future<User> getUser(bool refresh) async{
    if(refresh || loggedInUser == null) {
      final SharedPreferences prefs = await preferences;
      try {
        String email = prefs.get("loggedInEmail");
        print('email $email');
        var response = await http.get('${baseUrl}users/byemail/$email?role=fuelagent');
        print(response.body);
        if (response.statusCode == 200) {
          User usr = User.fromJson(json.decode(response.body)['data']);
          return usr;
        }
        return null;
      } catch (e) {
        print(e);
        return null;
      }
    }
    return loggedInUser;
  }
  
  Future<List<PaymentRecord>> getPaymentRecord(String filter, [bool refresh=false, int id]) async{
    print(refresh);
    if(paymentRecords == null || refresh == true){
      try{
        User user = await getUser(false);
        
        var response = await http.get('${baseUrl}paymentrecords/filter/${user.id}?filter=$filter&user=fuelagent');
        print(response.body);
        if(response.statusCode == 200){
          List<dynamic> prJson = json.decode(response.body)['data'];
          print(prJson);
          paymentRecords = List();
          prJson.forEach((pr){
            if(filter=='all'){
              PaymentRecord paymentRecord = PaymentRecord(
                price: double.parse(pr['price'].toString()),
                type: pr['type'],
                date: pr['created_at'],
              );
              paymentRecords.add(paymentRecord);
            }else if(filter=='monthly'){
              PaymentRecord paymentRecord = PaymentRecord(
                price: double.parse(pr['price'].toString()),
                type: pr['type'],
                date: pr['month'].toString() + '-' + pr['year'].toString(),
              );
              paymentRecords.add(paymentRecord);
            }else if(filter=='yearly') {
              PaymentRecord paymentRecord = PaymentRecord(
                price: double.parse(pr['price'].toString()),
                type: pr['type'],
                date: pr['year'].toString(),
              );
              paymentRecords.add(paymentRecord);
            }
          });
          print(paymentRecords);
          return paymentRecords;
        }
        return null;
      }catch(e){
        print(e);
        return null;
      }
    }
    return paymentRecords;
  }
  
  Future<List<PaymentRecord>> getDriverRecord(int id) async{
    List<PaymentRecord> driverRecord = List();
    try{
      var response = await http.get('${baseUrl}paymentrecords/filter/$id?filter=all&user=driver');
      print(response.body);
      if(response.statusCode == 200){
        List<dynamic> prRaw = json.decode(response.body)['data'];
        prRaw.forEach((pr){
          PaymentRecord paymentRecord = PaymentRecord.fromJson(pr);
          if(paymentRecord.type == 'payment'){
            driverRecord.add(PaymentRecord.fromJson(pr));
          }
        });
        return driverRecord;
      }
      return null;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<bool> changePassword(String password) async {
    try{
      User user = await getUser(false);
      var data = {
        'email': user.email,
        'name': user.name,
        'department_id': user.department.id.toString(),
        'status': user.status,
        'balance': user.balance.toString(),
        'password': password,
        '_method': 'PUT'
      };
      var response = await http.post('${baseUrl}users/${user.id}', body: data);
      print(response.body);
      if(response.statusCode == 200){
        return true;
      }
      return false;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<List<Driver>> getDrivers() async {
    List<Driver> drivers = List();
    try{
      var response = await http.get('${baseUrl}users/drivers');
      if(response.statusCode == 200){
        print(response.body);
        List<dynamic> usersraw = json.decode(response.body)['data'];
        print('rawuser: $usersraw');
        usersraw.forEach((rawuser){
          drivers.add(Driver.fromJson(rawuser));
        });
        return drivers;
      }
      return null;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<dynamic> getDriver(String email) async {

    try{
      var response = await http.get('${baseUrl}users/byemail/$email');
      var response2 = await http.get('${baseUrl}items?filter=all');
      print(response.body);
      print(response2.body);
      if(response.statusCode == 200 && response2.statusCode == 200){
        var rawUser = json.decode(response.body)['data'];
        List<dynamic> rawItems = json.decode(response2.body)['data'];
        Driver driver = Driver.fromJson(rawUser);
        Item fuel;
        rawItems.forEach((item){
          Item itm = Item.fromJson(item);
          if(itm.name=='fuel'){
            fuel = itm;
          }
        });
        if(rawUser==null || fuel ==null){
          return null;
        }else{
          return {
            'driver': driver,
            'fuel':fuel
          };
        }
      }
      return null;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<bool> processPayment(Driver driver, String peritem, String amount) async {
    try{
      User agent = await getUser(false);
      var data = {
        'balance':driver.balance.toString(),
        'agent_id': agent.id.toString(),
        'type': 'payment',
        'costperitem': peritem,
        'amount': amount,
        '_method': 'PATCH'
      };
      var response = await http.post('${baseUrl}users/payment/${driver.id}', body: data);
      print(response.body);
      if(response.statusCode == 200){
        return true;
      }
      return false;
    }catch(e){
      print(e);
      return false;
    }
    
  }
}