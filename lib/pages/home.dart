import 'package:flutter/material.dart';
import 'package:fuelcontrolseller/utils/constants.dart';
import 'package:fuelcontrolseller/viewModels/screens/home_view_model.dart';
import 'package:fuelcontrolseller/widgets/info_card.dart';
import 'package:fuelcontrolseller/widgets/retry.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder:(context, homeViewModel, child)=> homeViewModel.homeState == ViewState.Success? SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.only(bottom:15.0, left: 5.0, right: 5.0, top: 20.0),
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
                            'Profile',
                            style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
                          ),
                          Text(
                            'Name: ${homeViewModel.loggedInUser.name}',
                            style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                          ),
                          Text(
                            'Email: ${homeViewModel.loggedInUser.email}',
                            style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: (){
                              Scaffold.of(context).showBottomSheet((context) => _buildBottomSheet(context));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Text(
                                'change password',
                                style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.greenAccent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              InfoCard(
                title: 'Overall Sale',
                desc: '${homeViewModel.loggedInUser.totalSale} br',
                icon: Icon(
                  Icons.show_chart,
                  size: 45.0,
                ),
              ),
              InfoCard(
                title: 'Monthly Sale',
                desc: '${homeViewModel.loggedInUser.monthlySale} br',
                icon: Icon(
                  Icons.local_gas_station,
                  size: 45.0,
                ),
              ),
              InfoCard(
                title: 'Daily Sale',
                desc: '${homeViewModel.loggedInUser.dailySale} br',
                icon: Icon(
                  Icons.timelapse,
                  size: 45.0,
                ),
              ),
              SizedBox(height: 60.0,)
            ],
          ),
        ): homeViewModel.homeState == ViewState.Error?
        Retry(callback: (){homeViewModel.getUser(false);})
        :Center(
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

Widget _buildBottomSheet(BuildContext context){
  return ChangeNotifierProvider<HomeViewModel>(
    create: (context) => HomeViewModel(),
    child: Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black12,
            width: 2.0,
          )
      ),
      child: Container(
        padding: EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Text(
                'Change Password',
                style: Theme.of(context).textTheme.subtitle.copyWith(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
              ),
            ),
            Consumer<HomeViewModel>(
              builder:(context, homeViewModel, child) => homeViewModel.changePasswordState == ViewState.Error? Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Text(
                  '${homeViewModel.error}',
                  style: Theme.of(context).textTheme.body1.copyWith(color: Theme.of(context).errorColor),
                ),
              ): homeViewModel.changePasswordState == ViewState.Success ?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Text(
                  'password changed successfully',
                  style: Theme.of(context).textTheme.body1.copyWith(color: Colors.green, fontSize: 14.0),
                ),
              )
                  :Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<HomeViewModel>(
                builder:(context, homeViewModel, child) => TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'new password',
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 8.0
                      ),
                      labelStyle: TextStyle(
                        color: Theme.of(context).buttonColor,
                      )
                  ),
                  onChanged: (val){
                    homeViewModel.newPassword = val;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Consumer<HomeViewModel>(
                  builder:(context, homeViewModel, child) => FlatButton(
                    onPressed: (){
                      homeViewModel.changePassword();
                    },
                    color: Theme.of(context).primaryColor,
                    child: Consumer<HomeViewModel>(
                      builder:(context, homeViewModel, child)=> homeViewModel.changePasswordState == ViewState.Busy?
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ): Text(
                        'change password',
                        style: Theme.of(context).textTheme.body1,
                      ),
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