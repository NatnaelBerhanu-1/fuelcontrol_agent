import 'package:flutter/material.dart';
import 'package:fuelcontrolseller/utils/constants.dart';
import 'package:fuelcontrolseller/viewModels/screens/payment_record_view_model.dart';
import 'package:fuelcontrolseller/widgets/chart_item.dart';
import 'package:fuelcontrolseller/widgets/retry.dart';
import 'package:provider/provider.dart';

class SalesPage extends StatefulWidget {
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  num _filterIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChangeNotifierProvider<PaymentRecordViewModel>(
        create: (context) => PaymentRecordViewModel(),
        child: Consumer<PaymentRecordViewModel>(
          builder: (context, prViewModel, child) => prViewModel.prState == ViewState.Success? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 38,
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      border: Border.all(
                          color: Colors.white
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 50.0,
                        child: FlatButton(
                          color: _filterIndex==0?Theme.of(context).accentColor:Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                          ),
                          onPressed: (){
                            setState(() {
                              _filterIndex = 0;
                            });
                            prViewModel.getPaymentRecord('all', true);
                          },
                          child: Text(
                            'all',
                            style: TextStyle(color: _filterIndex==0?Colors.white:Theme.of(context).buttonColor),
                          ),
                        ),
                      ),
                      FlatButton(
                        color: _filterIndex==1?Theme.of(context).accentColor:Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                        ),
                        onPressed: (){
                          setState(() {
                            _filterIndex = 1;
                          });
                          prViewModel.getPaymentRecord('monthly', true);
                        },
                        child: Text(
                          'monthly',
                          style: TextStyle(color: _filterIndex==1?Colors.white:Theme.of(context).buttonColor),
                        ),
                      ),
                      FlatButton(
                        color: _filterIndex==2?Theme.of(context).accentColor:Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                        ),
                        onPressed: (){
                          setState(() {
                            _filterIndex = 2;
                          });
                          prViewModel.getPaymentRecord('yearly', true);
                        },
                        child: Text(
                          'yearly',
                          style: TextStyle(color: _filterIndex==2?Colors.white:Theme.of(context).buttonColor),
                        ),
                      ),
                    ],
                  ),
                ),
//                Padding(
//                  padding: const EdgeInsets.symmetric(vertical: 8.0),
//                  child: ConstrainedBox(
//                    constraints: BoxConstraints.expand(height: 200.0),
//                    child: ChartItem(),
//                  ),
//                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0, bottom: 16.0),
                  child: Text(
                    'Payment Record',
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      border: TableBorder(
                          bottom: BorderSide(
                              color: Colors.white,
                              width: 1.0
                          )
                      ),
                      children:
                      prViewModel.paymentRecords.map((paymentRecord) => TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${paymentRecord.date}',
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
                            '${paymentRecord.price} br',
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
                            'sales',
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(fontSize: 14.0,),
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
                  ),
                ),
                SizedBox(height: 60.0,)
              ],
            ),
          ): prViewModel.prState == ViewState.Error?
          Retry(callback: (){prViewModel.getPaymentRecord('all', false);})
          :Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
