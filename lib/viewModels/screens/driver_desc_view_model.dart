import 'package:flutter/foundation.dart';
import 'package:fuelcontrolseller/models/models.dart';
import 'package:fuelcontrolseller/repositories/user_repository.dart';
import 'package:fuelcontrolseller/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverDescViewModel extends ChangeNotifier {
  UserRepository _userRepository;
  Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
  ViewState pageState = ViewState.Idle;
  List<PaymentRecord> driverRecords;

  DriverDescViewModel(int id){
    if(_userRepository == null) {
      _userRepository = UserRepository(preferences: _sharedPreferences);
    }
    getDriverRecord(id);
  }

  Future<bool> getDriverRecord(int id) async{
    setState(ViewState.Busy);
    var response = await _userRepository.getDriverRecord(id);
    if(response != null){
      driverRecords = response;
      setState(ViewState.Success);
      return true;
    }
    setState(ViewState.Error);
    return false;
  }

  setState(ViewState state){
    pageState = state;
    notifyListeners();
  }
}