import 'package:flutter/material.dart';
import 'package:fuelcontrolseller/models/models.dart';
import 'package:fuelcontrolseller/utils/constants.dart';
import 'package:fuelcontrolseller/viewModels/screens/driver_desc_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DriverDescPage extends StatelessWidget{

  Driver driver;

  DriverDescPage({@required this.driver});

  final tableData = [
    Invoice(
      price: 1234.2,
      time: DateTime.now(),
    ),
    Invoice(
      price: 1234.2,
      time: DateTime.now(),
    ),
    Invoice(
      price: 1234.2,
      time: DateTime.now(),
    ),
    Invoice(
      price: 1234.2,
      time: DateTime.now(),
    ),
    Invoice(
      price: 1234.2,
      time: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'Driver Description'
        ),
      ),
      body: ChangeNotifierProvider<DriverDescViewModel>(
        create: (context) => DriverDescViewModel(driver.id),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.only(bottom:15.0, left: 5.0, right: 5.0, top: 20),
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor],
                        begin:Alignment.topLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Driver Profile',
                            style: Theme.of(context).textTheme.title.copyWith(color: Colors.white, fontSize: 22.0),
                          ),
                          Text(
                            'Name: ${driver.name}',
                            style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                          ),
                          Text(
                            'Balance: ${driver.balance} br',
                            style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                          ),
                          Text(
                            'Email: ${driver.email}',
                            style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                          ),
                          Text(
                            'Status: ${driver.status}',
                            style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0, bottom: 16.0),
                child: Text(
                  'Drivers Record',
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                child: Consumer<DriverDescViewModel>(
                  builder:(context, viewModel, child) => viewModel.pageState == ViewState.Success? Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      border: TableBorder(
                          bottom: BorderSide(
                              color: Colors.white,
                              width: 1.0
                          )
                      ),
                      children:
                      viewModel.driverRecords.map((driverRecord) => TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${driverRecord.date}',
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(fontSize: 14.0,),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${driverRecord.price} br',
                            style: Theme.of(context)
                                .textTheme
                                .body1,
                            textAlign: TextAlign.center,

                          ),
                        )
                      ],
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.white
                                  )
                              )
                          )
                      ),).toList()
                  ): Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}