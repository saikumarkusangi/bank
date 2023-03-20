
import 'package:badges/badges.dart' as badge;
import 'package:bank/constants/constants.dart';
import 'package:bank/core.dart';

import 'package:flutter/material.dart';

import '../../../dummyData/dummy_data.dart';
import '../../widgets/action_box.dart';
import '../../widgets/avatar_image.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/credit_card.dart';
import '../../widgets/transaction_item.dart';
import '../../widgets/user_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
     return 
      SafeArea(
        child: Stack(
          children: 
            [  
              // SizedBox(
              //     width: MediaQuery.of(context).size.width,
              //     height: MediaQuery.of(context).size.height ,
              //     child: Image.network('https://pbs.twimg.com/ext_tw_video_thumb/1556639542861389825/pu/img/hatEa7wvZIFUyqWt.jpg:large'),
              //   ),
              Scaffold(
              backgroundColor: Colors.transparent,
               appBar: getAppBar(),
              body: getBody(),
            ),
          ],
        ),
      );
  }

  getAppBar(){
    return 
      PreferredSize(
        preferredSize: Size(double.maxFinite, 80),
        child: Container(
        height: 80,
        padding: EdgeInsets.only(left: 20, right: 20, top: 5),
        decoration: BoxDecoration(
          color: ThemeColors.appBgColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: ThemeColors.shadowColor.withOpacity(0.1),
              blurRadius: .5,
              spreadRadius: .5,
              offset: Offset(0, 1)
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarImage(profile, isSVG: false, width: 35, height: 35),
            SizedBox(width: 15,),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Greetings.greetingText(), style: TextStyle(color: Colors.grey, fontSize: 18),),
                    SizedBox(height: 5,),
                    Text("Sai", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),),
                  ],
                ),
              )
            ),
            SizedBox(width: 15,),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(1, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Icon(Icons.notifications_rounded)
              // child: badge(
              //   padding: const EdgeInsets.all(3),
              //   position: badge.BadgePosition.topEnd(top: -5, end: 2),
              //   badgeContent: Text('', style: TextStyle(color: Colors.white),),
              //   child: Icon(Icons.notifications_rounded)
              // ),
            ),
          ],
        ),
                ),
      );
  }

  getBody(){
    return
    SingleChildScrollView(
      child: Column(
        children: [
          // getAppBar(),
          const SizedBox(height: 25,),
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: CreditCard()
          ),
          const SizedBox(height: 35,),
          getActions(),
          const SizedBox(height: 25,),
          Container(
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: const Text("Send Again", 
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),)
          ),
          const SizedBox(height: 15,),
          Padding(padding: const EdgeInsets.only(left: 15),
            child: getRecentUsers(),
          ),
          const SizedBox(height: 25,),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 15),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Transactions", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text("Today", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),))
                ),
                const Icon(Icons.expand_more_rounded),
              ],
            )
          ),
          const SizedBox(height: 15,),
          Padding(padding: EdgeInsets.only(left: 15),
            child: getTransanctions(),
          ),
        ],
      ),
    );
  }

  getActions(){
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 15,),
          Expanded(
            child: InkWell(
              onTap: ()=>  NetworkServices.sendMoney(),
              child: ActionBox(title: "Send", icon: Icons.send_rounded, bgColor: ThemeColors.green,))
          ),
          SizedBox(width: 15,),
          Expanded(
            child: ActionBox(title: "Request", icon: Icons.arrow_circle_down_rounded, bgColor: ThemeColors.yellow)
          ),
          SizedBox(width: 15,),
          Expanded(
            child: ActionBox(title: "More", icon: Icons.widgets_rounded, bgColor: ThemeColors.purple)
          ),
          SizedBox(width: 15,),
        ],
      );
  }

  getRecentUsers(){
    return
      SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 5),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(recentUsers.length, (index) => 
            index == 0 ?
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: getSearchBox(),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: UserBox(user: recentUsers[index])
                ) 
              ],
            )
            : 
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: UserBox(user: recentUsers[index])
            ) 
          )
        ),
      );
  }

  getSearchBox(){
    return
      Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle
          ),
          child: Icon(Icons.search_rounded),
        ),
        SizedBox(height: 8,),
        Text("Search", style: TextStyle(fontWeight: FontWeight.w500),)
      ],
    );
  }

  getTransanctions(){
    return
      Column(
        children: List.generate(transactions.length, (index) => 
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: TransactionItem(transactions[index])
          ) 
        )
      );
  }
}