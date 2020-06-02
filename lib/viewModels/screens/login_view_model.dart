import 'package:flutter/foundation.dart';
import 'package:fuelcontrolseller/models/models.dart';
import 'package:fuelcontrolseller/repositories/user_repository.dart';
import 'package:fuelcontrolseller/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {

  UserRepository _userRepository;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  LoginViewModel(){
    if(_userRepository == null){
      _userRepository = UserRepository(preferences: _prefs);
    }
  }

  String email = '';
  String password = '';
  ViewState loginState = ViewState.Idle;

  Future<bool> login(User user) async{
    print('loggin lvm');
    setState(ViewState.Busy);
    var response = await _userRepository.login(user);
    if(response){
      setState(ViewState.Idle);
    }else{
      setState(ViewState.Error);
    }
    return response;
  }

  setState(ViewState state){
    loginState = state;
    notifyListeners();
  }
}