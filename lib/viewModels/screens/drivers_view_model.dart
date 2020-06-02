import 'package:flutter/foundation.dart';
import 'package:fuelcontrolseller/models/models.dart';
import 'package:fuelcontrolseller/repositories/user_repository.dart';
import 'package:fuelcontrolseller/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriversViewModel extends ChangeNotifier {
  UserRepository _userRepository;
  Future<SharedPreferences> _sharedPreference = SharedPreferences.getInstance();
  ViewState pageState = ViewState.Idle;
  List<Driver> drivers;

  DriversViewModel() {
    if(_userRepository == null){
      _userRepository = UserRepository(preferences: _sharedPreference);
    }
    getDrivers();
  }

  Future<bool> getDrivers() async{
    var response = await _userRepository.getDrivers();
    if(response == null){
      setState(ViewState.Error);
      return false;
    }
    setState(ViewState.Success);
    drivers = response;
    return true;
  }

  setState(ViewState state){
    pageState = state;
    notifyListeners();
  }
}