import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/user_controller.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserController>(context);
    return Stack(
      children: [
        SizedBox(child: Image.asset('assets/images/card_template.png')),
        Positioned(
            top: 5,
            right: 20,
            child: SizedBox(
                width: 150, child: Image.asset('assets/images/banner.png'))),
        Positioned(
            top: 70,
            right: 40,
            child: SizedBox(
                child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Current Balance:\n",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
                TextSpan(
                    text: "₹ ${userDataProvider.currentBalance}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                    ))
              ]),
            ))),
        Positioned(
            bottom: 50,
            left: 20,
            child: SizedBox(
                child: Text(
              'XXXX XXXX XXXX XXXX',
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 18,
              ),
            ))),
        Positioned(
            bottom: 20,
            left: 20,
            child: SizedBox(
                child: Text(
              userDataProvider.fullName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            )))
      ],
    );
  }
}
