import 'dart:async';
import 'dart:math';

import 'package:badges/badges.dart' as badge;
import 'package:bank/constants/constants.dart';
import 'package:bank/core.dart';
import 'package:bank/models/user_model.dart';
import 'package:bank/views/features/send/send_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controllers/user_controller.dart';
import '../../../dummyImages/dummy_data.dart';
import '../../widgets/action_box.dart';
import '../../widgets/avatar_image.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/credit_card.dart';
import '../../widgets/transaction_item.dart';
import '../../widgets/user_box.dart';
import '../request/request.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static bool balance = false;
  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserController>(context);

    return SafeArea(
      child: Stack(
        children: [
          // SizedBox(
          //     width: MediaQuery.of(context).size.width,
          //     height: MediaQuery.of(context).size.height ,
          //     child: Image.network('https://pbs.twimg.com/ext_tw_video_thumb/1556639542861389825/pu/img/hatEa7wvZIFUyqWt.jpg:large'),
          //   ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size(double.maxFinite, 80),
              child: Container(
                height: 80,
                padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                decoration: BoxDecoration(
                    color: ThemeColors.appBgColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                          color: ThemeColors.shadowColor.withOpacity(0.1),
                          blurRadius: .5,
                          spreadRadius: .5,
                          offset: Offset(0, 1))
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AvatarImage(Images.avatars[Random().nextInt(1)], isSVG: false, width: 35, height: 35),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Container(
                      alignment: Alignment.centerLeft,
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Greetings.greetingText(),
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            userDataProvider.nickName,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 22),
                          ),
                        ],
                      ),
                    )),
                    SizedBox(
                      width: 15,
                    ),
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
                              offset:
                                  Offset(1, 1), // changes position of shadow
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
            ),
            body: getBody(),
          ),
        ],
      ),
    );
  }

  getBody() {
    final provider = Provider.of<UserController>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          // getAppBar(),
          const SizedBox(
            height: 25,
          ),
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: (!balance) ? CreditCard() : BalanceCard()),
          const SizedBox(
            height: 35,
          ),
          getActions(),
          const SizedBox(
            height: 25,
          ),

          // const SizedBox(
          //   height: 15,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 15),
          //   child: getRecentUsers(),
          // ),
          const SizedBox(
            height: 25,
          ),
          Container(
              padding: const EdgeInsets.only(left: 20, right: 15),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Transactions",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  // Expanded(
                  //     child: Container(
                  //         alignment: Alignment.centerRight,
                  //         child: Text(
                  //           "Today",
                  //           style: TextStyle(
                  //               fontSize: 14, fontWeight: FontWeight.w500),
                  //         ))),
                  const Icon(Icons.expand_more_rounded),
                ],
              )),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: getTransanctions(),
          ),
          (provider.history.length > 5)
              ? Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'See More',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                )
              : const SizedBox(
                  height: 0,
                )
        ],
      ),
    );
  }

  getActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 15,
        ),
        Expanded(
            child: InkWell(
                onTap: () => Get.to(const SendPage(),
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 200)),
                child: ActionBox(
                  title: "Send",
                  icon: Icons.send_rounded,
                  bgColor: ThemeColors.green,
                ))),
        const SizedBox(
          width: 15,
        ),
        Expanded(
            child: InkWell(
          onTap: () => Get.to(const RequestPage()),
          child: ActionBox(
              title: "Request",
              icon: Icons.arrow_circle_down_rounded,
              bgColor: ThemeColors.yellow),
        )),
        const SizedBox(
          width: 15,
        ),
        Expanded(
            child: InkWell(
          onTap: () {
            if (balance) {
              setState(() {
                balance = false;
              });
            } else {
              setState(() {
                balance = true;
                Timer(const Duration(seconds: 3), () {
                  setState(() {
                    balance = false;
                  });
                });
              });
            }
          },
          child: ActionBox(
              title: "Balance",
              icon: Icons.account_balance_wallet_rounded,
              bgColor: ThemeColors.purple),
        )),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }

  // getRecentUsers() {
  //   final provider = Provider.of<UserController>(context);
  //   bool showTitle = false;
  //   return SingleChildScrollView(
  //     padding: EdgeInsets.only(bottom: 5),
  //     scrollDirection: Axis.horizontal,
  //     child: Column(
  //       children: [
  //         (showTitle)
  //             ? Container(
  //                 padding: const EdgeInsets.only(left: 20),
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(
  //                   "Send Again",
  //                   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
  //                 ))
  //             : SizedBox(
  //                 height: 0,
  //               ),
  //         Row(
  //             children: List.generate(
  //                 (provider.history.length > 5) ? 5 : provider.history.length,
  //                 (index) {
  //           final sent = provider.history[index]['amount'];
            
  //           if (sent.toString().contains('-')) {
  //             setState(() {
  //               showTitle = true;
  //             });
  //           }
  //           return index == 0
  //               ? Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     Container(
  //                         margin: const EdgeInsets.only(right: 15),
  //                         child: (sent.toString().contains('-'))
  //                             ? getSearchBox()
  //                             : SizedBox(width: 0,)),
  //                     Container(
  //                         margin: const EdgeInsets.only(right: 15),
  //                         child: (sent.toString().contains('-'))
  //                             ? UserBox(user: provider.history[index])
  //                             : SizedBox(width: 0,))
  //                   ],
  //                 )
  //               : Container(
  //                   margin: const EdgeInsets.only(right: 15),
  //                   child: (sent.toString().contains('-'))
  //                       ? UserBox(user: provider.history[index])
  //                       : null);
  //         })),
  //       ],
  //     ),
  //   );
  // }

  // getSearchBox() {
  //   return Column(
  //     children: [
  //       Container(
  //         padding: EdgeInsets.all(15),
  //         decoration: BoxDecoration(
  //             color: Colors.grey.shade300, shape: BoxShape.circle),
  //         child: Icon(Icons.search_rounded),
  //       ),
  //       SizedBox(
  //         height: 8,
  //       ),
  //       Text(
  //         "Search",
  //         style: TextStyle(fontWeight: FontWeight.w500),
  //       )
  //     ],
  //   );
  // }

  getTransanctions() {
    final provider = Provider.of<UserController>(context);
    return Column(
        children: List.generate(
            (provider.history.length > 5) ? 5 : provider.history.length,
            (index) => Container(
                margin: const EdgeInsets.only(right: 15),
                child: TransactionItem(provider.history[index]))));
  }
}
