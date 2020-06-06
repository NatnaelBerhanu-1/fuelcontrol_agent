import 'package:flutter/foundation.dart';
import 'package:fuelcontrolseller/models/models.dart';
import 'package:fuelcontrolseller/repositories/user_repository.dart';
import 'package:fuelcontrolseller/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeViewModel extends ChangeNotifier{

  String error;
  String newPassword = '';
  ViewState homeState = ViewState.Idle;
  ViewState changePasswordState = ViewState.Idle;
  User loggedInUser;
  
  UserRepository _userRepository;
  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();

  HomeViewModel(){
    if (_userRepository == null){
      _userRepository = UserRepository(preferences: sharedPreferences);
    }
//    getUser(false);
  }

  Future<User> getUser(bool refresh) async {
    if(!refresh && loggedInUser!=null){
      return loggedInUser;
    }
    print('Gettting user');
    setState(ViewState.Busy);
    User user = await _userRepository.getUser(refresh);
    if(user == null){
      print('user is null');
      error = 'error getting user';
      setState(ViewState.Error);
      return null;
    }
    print('user is not null');
    setState(ViewState.Success);
    loggedInUser = user;
    return user;
  }

  Future<bool> changePassword() async{
    if(newPassword.length < 4){
      error = 'minimum length is 4';
      setChangePasswordState(ViewState.Error);
      return false;
    }
    error = '';
    notifyListeners();
    setChangePasswordState(ViewState.Busy);
    bool response = await _userRepository.changePassword(newPassword);
    if(response == true){
      newPassword = '';
      notifyListeners();
      setChangePasswordState(ViewState.Success);
      return true;
    }
    setChangePasswordState(ViewState.Error);
    return null;
  }

  setState(ViewState state){
    homeState = state;
    notifyListeners();
  }

  setChangePasswordState(ViewState state){
    changePasswordState = state;
    notifyListeners();
  }


}