import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
         child: Image.asset('assets/images/card_template.png')
        ),
        Positioned(
          top:5,right:20,
          child: SizedBox(
          width: 150,
          child: Image.asset('assets/images/banner.png'))
        ),
         Positioned(
          bottom:50,left:20,
          child: SizedBox(
          width: 80,
          child: Text('XXXX XXXX XXXX 2412',style:TextStyle(color:Colors.white,fontSize:18,),))
        ),
         Positioned(
          bottom:20,left:20,
          child: SizedBox(
          width: 80,
          child: Text('sai kumar kusangi',style:TextStyle(color:Colors.white,fontSize:18,),))
        )
       
      
      ],
    );
  }
}