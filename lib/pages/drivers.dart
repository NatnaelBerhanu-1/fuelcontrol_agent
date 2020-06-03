import 'package:flutter/material.dart';
import 'package:fuelcontrolseller/utils/constants.dart';
import 'package:fuelcontrolseller/viewModels/screens/drivers_view_model.dart';
import 'package:fuelcontrolseller/widgets/driver_item.dart';
import 'package:fuelcontrolseller/widgets/retry.dart';
import 'package:provider/provider.dart';

class DriversPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider<DriversViewModel>(
      create: (context)=>DriversViewModel(),
      child: Consumer<DriversViewModel>(
        builder:(context, viewModel, child )=> viewModel.pageState == ViewState.Success? SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                viewModel.drivers.map((driver){
                  return DriverItem(driver: driver,);
                }).toList(),
            ),
          ),
        ): viewModel.pageState == ViewState.Error? Retry(callback: (){viewModel.getDrivers();}): Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}