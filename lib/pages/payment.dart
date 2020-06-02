import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuelcontrolseller/utils/constants.dart';
import 'package:fuelcontrolseller/viewModels/screens/payment_view_model.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  String barcode;

  PaymentPage({@required this.barcode});

  @override
  State<StatefulWidget> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String litre, feeError;
  double total = 0.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider<PaymentViewModel>(
      create: (context) => PaymentViewModel(widget.barcode),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Payment'),
          centerTitle: true,
        ),
        body: Consumer<PaymentViewModel>(
          builder: (context, viewModel, child) => viewModel.paymentState ==
                  ViewState.Success
              ? Center(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Payment Successfull',
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 52.0,
                            child: FlatButton(
                              color: Theme.of(context).accentColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'okay',
                                style: Theme.of(context).textTheme.body1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : viewModel.getDriverState == ViewState.Success
                  ? SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
//            _paymentSucceeded(context),

                          Card(
                            margin: EdgeInsets.only(
                                bottom: 15.0, left: 5.0, right: 5.0),
                            color: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              margin: EdgeInsets.only(top: 20.0),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).primaryColor,
                                      Theme.of(context).accentColor
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Driver',
                                        style: Theme.of(context)
                                            .textTheme
                                            .title
                                            .copyWith(color: Colors.white),
                                      ),
                                      Text(
                                        'Name: ${viewModel.driver.name}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle
                                            .copyWith(color: Colors.white),
                                      ),
                                      Text(
                                        'Balance: ${viewModel.driver.balance} br',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle
                                            .copyWith(color: Colors.white),
                                      ),
                                      Text(
                                        'Email: ${viewModel.driver.email}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle
                                            .copyWith(color: Colors.white),
                                      ),
                                      Text(
                                        'Status: ${viewModel.driver.status}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                  'Fuel: ${viewModel.fuel.price} br per litre'),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Total: $total'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 20.0, bottom: 8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    feeError = null;
                                  });
                                }
                                setState(() {
                                  litre = value;
                                  total = double.parse(litre) *
                                      viewModel.fuel.price;
                                });
                              },
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                errorText: feeError,
                                hintText: 'fuel in litre',
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2.0),
                                ),
                                hintStyle: TextStyle(
                                    color: Theme.of(context).buttonColor),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: Colors.white70, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: Colors.white70, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            margin: EdgeInsets.only(top: 10.0),
                            height: 52.0,
                            width: MediaQuery.of(context).size.width,
                            child: FlatButton(
                              color: Theme.of(context).accentColor,
                              onPressed: () {
                                if (litre == null || litre == '') {
                                  setState(() {
                                    feeError = 'field required';
                                  });
                                  return;
                                } else if (double.parse(litre) < 0) {
                                  setState(() {
                                    feeError = 'invalid fee';
                                  });
                                  return;
                                }
                                viewModel.processPayment(total, litre);
                              },
                              child: viewModel.paymentState == ViewState.Busy
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    )
                                  : Text(
                                      'proceed',
                                      style: Theme.of(context).textTheme.body1,
                                    ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                          ),
                          viewModel.paymentState == ViewState.Error
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Text(
                                    '${viewModel.paymentError}',
                                    style: TextStyle(
                                        color: Theme.of(context).errorColor),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }

//  Widget _paymentSucceeded(BuildContext context){
//    return Column(
//      children: <Widget>[
//        Container(
//          height: 100,
//          width: 100,
//          margin: EdgeInsets.only(top: 24),
//          decoration: BoxDecoration(
//            color: Colors.white,
//            borderRadius: BorderRadius.all(Radius.circular(50))
//          ),
//          child: Center(
//            child: Icon(
//              Icons.check,
//              size: 90.0,
//              color: Theme.of(context).primaryColor,
//            ),
//          ),
//        ),
//        Text(
//            'process completed\nsuccesfully',
//          style: TextStyle(
//            color: Theme.of(context).accentColor,
//            fontSize: 24.0,
//            fontWeight: FontWeight.bold,
//          ),
//          textAlign: TextAlign.center,
//        ),
//        Container(
//          padding: EdgeInsets.symmetric(horizontal: 5.0),
//          margin: EdgeInsets.only(top: 20.0),
//          height: 52.0,
//          width: MediaQuery.of(context).size.width,
//          child: FlatButton(
//            color: Theme.of(context).primaryColor,
//            onPressed: () {
//              if (fee == null || fee == '') {
//                setState(() {
//                  feeError = 'field required';
//                });
//                return;
//              } else if ( double.parse(fee) > 0) {
//                setState(() {
//                  feeError = 'invalid fee';
//                });
//                return;
//              }
//            },
//            child: Text(
//              'go back',
//              style: Theme.of(context).textTheme.body1,
//            ),
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.all(Radius.circular(10.0))),
//          ),
//        ),
//      ],
//    );
//  }
}
