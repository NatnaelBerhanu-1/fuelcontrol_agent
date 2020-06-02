import 'package:flutter/foundation.dart';
import 'package:fuelcontrolseller/models/models.dart';
import 'package:fuelcontrolseller/repositories/user_repository.dart';
import 'package:fuelcontrolseller/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PaymentRecordViewModel extends ChangeNotifier{

  UserRepository _userRepository;
  Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
  ViewState prState;
  List<PaymentRecord> paymentRecords;

  PaymentRecordViewModel(){
    if(_userRepository == null){
      _userRepository = UserRepository(preferences: _sharedPreferences);
    }
    getPaymentRecord('all', false);
  }

  setState(ViewState state){
    prState = state;
    notifyListeners();
  }

  Future<List<PaymentRecord>> getPaymentRecord(String filter, bool refresh) async{
    setState(ViewState.Busy);
    var response = await _userRepository.getPaymentRecord(filter, refresh);
    if(response == null){
      setState(ViewState.Error);
      return null;
    }
    paymentRecords = response;
    setState(ViewState.Success);
  }

}