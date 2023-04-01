import 'dart:async';
import 'dart:math';

import 'package:badges/badges.dart' as badge;
import 'package:bank/constants/constants.dart';
import 'package:bank/controllers/controllers.dart';
import 'package:bank/controllers/history_controller.dart';
import 'package:bank/core.dart';
import 'package:bank/models/user_model.dart';
import 'package:bank/views/features/send/send_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../controllers/speech_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../dummyImages/dummy_data.dart';
import '../../widgets/action_box.dart';
import '../../widgets/avatar_image.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/credit_card.dart';
import '../../widgets/transaction_item.dart';
import '../../widgets/user_box.dart';
import '../history/history.dart';
import '../request/request.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
              preferredSize: const Size(double.maxFinite, 80),
              child: Container(
                height: 80,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                decoration: BoxDecoration(
                    color: ThemeColors.appBgColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                          color: ThemeColors.shadowColor.withOpacity(0.1),
                          blurRadius: .5,
                          spreadRadius: .5,
                          offset: const Offset(0, 1))
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AvatarImage(Images.avatars[1],
                        isSVG: false, width: 35, height: 35),
                    const SizedBox(
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
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            userDataProvider.nickName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 22),
                          ),
                        ],
                      ),
                    )),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  1, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Icon(Icons.notifications_rounded)
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
    return Consumer<HistoryController>(
      builder: (context, value, child) => RefreshIndicator(
        onRefresh: () async {
          await value.transactions();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: (!value.balance)
                      ? const CreditCard()
                      : const BalanceCard()),
              const SizedBox(
                height: 35,
              ),
              getActions(),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 15),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                        "Transactions".tr,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      Icon(Icons.expand_more_rounded),
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                    children: List.generate(
                        (value.history.length > 5) ? 5 : value.history.length,
                        (index) => Container(
                            margin: const EdgeInsets.only(right: 15),
                            child: TransactionItem(value.history[index])))),
              ),
              (value.history.length > 5)
                  ? Padding(
                      padding: const EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () => Get.to(const History(),transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 200)),
                        child:  Text(
                          'See More'.tr,
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    )
            ],
          ),
        ),
      ),
    );
  }

  getActions() {
    final pinController = TextEditingController();
    final provider = Provider.of<HistoryController>(context);
    final pinProvider = Provider.of<UserController>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
          width: 15,
        ),
        Expanded(
            child: InkWell(
                onTap: () => Get.to(const SendPage(),
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 200)),
                child: ActionBox(
                  title: "Send".tr,
                  icon: Icons.send_rounded,
                  bgColor: ThemeColors.green,
                ))),
        const SizedBox(
          width: 15,
        ),
        Expanded(
            child: InkWell(
          onTap: () => Get.to(const RequestPage(),transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 200)),
          child: ActionBox(
              title: "Request".tr,
              icon: Icons.arrow_circle_down_rounded,
              bgColor: ThemeColors.yellow),
        )),
        const SizedBox(
          width: 15,
        ),
        Expanded(
            child: InkWell(
          onTap: () {
            final command = Provider.of<MicController>(context,listen: false);
            
            (command.bottomSheet)
                ? showBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        color: ThemeColors.background,
                        height: MediaQuery.of(context).size.height / 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text(
                                "Enter Your Pin".tr,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Pinput(
                                controller: pinController,
                                closeKeyboardWhenCompleted: true,
                                obscureText: true,
                                length: 6,
                                defaultPinTheme: PinTheme(
                                  width: 56,
                                  height: 56,
                                  textStyle: const TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(19),
                                    border: Border.all(color: Colors.white),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.length < 6) {
                                    return 'Enter 6 digits pin'.tr;
                                  }
                                  return null;
                                },
                                cursor: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 9),
                                      width: 22,
                                      height: 1,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  if (pinController.text ==
                                      pinProvider.pinNumber.trim()) {
                                    if (provider.balance) {
                                      provider.showBalance(false);
                                      Navigator.pop(context);
                                    } else {
                                      final amount =
                                          Provider.of<UserController>(context,
                                              listen: false);
                                      SpeechController.listen(
                                          "your account balance is ruppess  ${amount.currentBalance}");

                                      provider.showBalance(true);
                                      Navigator.pop(context);
                                    }
                                  } else {
                                    SpeechController.listen(
                                        "please check your pin");
                                    Get.snackbar('please check your pin',
                                        'please check your pin');
                                  }
                                },
                                child:  Chip(
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  label: Text('Login'.tr),
                                  labelStyle: TextStyle(
                                      color: ThemeColors.background,
                                      fontSize: 26),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : null;
          },
          child: ActionBox(
              title: "Balance".tr,
              icon: Icons.account_balance_wallet_rounded,
              bgColor: ThemeColors.purple),
        )),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
