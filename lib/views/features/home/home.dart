
import 'package:bank/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../views.dart';
import '../../widgets/bottom_navigation_items.dart';
import '../../widgets/mic.dart';
class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColors.appBgColor.withOpacity(.95),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40), 
          topRight: Radius.circular(40)
        ), 
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: getBottomBar(),
        floatingActionButton: getHomeButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        body: getBarPage()
      ),
    );
  }

  Widget getHomeButton(){
    return Positioned(
      child: Mic());
  }

  Widget getBottomBar() {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeColors.bottomBarColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), 
          topRight: Radius.circular(25)
        ), 
        boxShadow: [
          BoxShadow(
            color: ThemeColors.shadowColor.withOpacity(0.1),
            blurRadius: .5,
            spreadRadius: .5,
            offset: Offset(0, 1)
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomBarItem(Icons.home_rounded, "", isActive: activeTab == 0, activeColor: ThemeColors.primary,
                onTap: () {
                  setState(() {
                    activeTab = 0;
                  });
                },
              ),
              BottomBarItem(Icons.account_balance_wallet_rounded, "", isActive: activeTab == 1, activeColor: ThemeColors.primary,
                onTap: () {
                  setState(() {
                    activeTab = 1;
                  });
                },
              ),
             
              BottomBarItem(Icons.history, "", isActive: activeTab == 2, activeColor: ThemeColors.primary,
                onTap: () {
                  setState(() {
                    activeTab = 2;
                  });
                },
              ),
              BottomBarItem(Icons.person_rounded, "", isActive: activeTab == 3, activeColor: ThemeColors.primary,
                onTap: () {
                  setState(() {
                    activeTab = 3;
                  });
                },
              ),
            ]
          )
        ),
    );
  }

  Widget getBarPage(){
    return 
      IndexedStack(
        index: activeTab,
        children: <Widget>[
          HomePage(),
          Center(
            child: Text("Wallet",style: TextStyle(
              fontSize: 35
            ),),
          ),
          
          Center(
            child: Text("History",style: TextStyle(
              fontSize: 35
            ),),
          ),
           Center(
            child: Text("Account",style: TextStyle(
              fontSize: 35
            ),),
          )
        ],
      );
  }
}