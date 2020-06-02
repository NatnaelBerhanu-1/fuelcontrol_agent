import 'package:flutter/foundation.dart';
import 'package:fuelcontrolseller/models/models.dart';
import 'package:fuelcontrolseller/repositories/user_repository.dart';
import 'package:fuelcontrolseller/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentViewModel extends ChangeNotifier{

  UserRepository _userRepository;
  Future<SharedPreferences> _preference = SharedPreferences.getInstance();
  ViewState getDriverState = ViewState.Idle;
  ViewState paymentState = ViewState.Idle;
  Driver driver;
  Item fuel;
  String paymentError;

  PaymentViewModel(String email){
    if(_userRepository == null){
      _userRepository = new UserRepository(preferences: _preference);
    }
    getDriver(email);
  }

  Future<bool> getDriver(String email) async {
    setGetDriverState(ViewState.Busy);
    var response = await _userRepository.getDriver(email);
    if(response != null){
      driver = response['driver'];
      fuel = response['fuel'];
      setGetDriverState(ViewState.Success);
      return true;
    }
    return null;
  }

  Future<bool> processPayment(double fee, String amount) async {
    setPaymentState(ViewState.Busy);
    if(driver.status == "inactive"){
      paymentError = 'Driver needs to be activated';
      setPaymentState(ViewState.Error);
      return null;
    }else if(fee > driver.balance){
      paymentError = 'Total price is greater than drivers balance';
      setPaymentState(ViewState.Error);
      return null;
    }else{
      driver.balance = driver.balance - fee;
      var response = await _userRepository.processPayment(driver, fuel.price.toString(), amount);
      if(response){
        setPaymentState(ViewState.Success);
        return true;
      }
      paymentError = 'Something went wrong try again';
      setPaymentState(ViewState.Error);
      return false;
    }
  }

  setGetDriverState(ViewState state){
    getDriverState = state;
    notifyListeners();
  }

  setPaymentState(ViewState state){
    paymentState = state;
    notifyListeners();
  }

}