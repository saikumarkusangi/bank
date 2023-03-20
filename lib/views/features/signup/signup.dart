import 'package:avatar_glow/avatar_glow.dart';
import 'package:bank/constants/constants.dart';
import 'package:bank/views/features/pinsetup/pin_set_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../../controllers/controllers.dart';
import '../../../controllers/mic_controller.dart';
import '../../../main.dart';
import '../../views.dart';
import '../../widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage ({Key? key}) : super(key: key);
  
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage > {
 
  @override
  Widget build(BuildContext context) {
    final keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    
     final focusNode = FocusNode();
      final focusNode1 = FocusNode();
    final formKey = GlobalKey<FormState>();
        
     final micProvider = Provider.of<MicController>(context);


 const focusedBorderColor = Colors.white;
    const fillColor = Colors.white;
    const borderColor = Colors.blue;
final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 32,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    final DisableTheme = PinTheme(
      width: 56,
      height: 56,
  
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return  SafeArea(
      child: GestureDetector(
        onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: ThemeColors.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Center(
               child: SizedBox(
                width: MediaQuery.of(context).size.width*0.9,
                child: Image.asset(Images.loginbanner)),
               
                ),
                const Text('Create Account',style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 32
                ),),
              const Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 20),
                 child:  Divider(
                  thickness: 2,
                    color: Colors.white,
                  ),
               ),
               const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.text,
                         style:const TextStyle(fontSize: 20),
                      
                        decoration: InputDecoration(
                           hintStyle:const TextStyle(fontSize: 18),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'enter nick name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                    
                      ),
                    const SizedBox(height: 10,),
                     TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.text,
                         style:const TextStyle(fontSize: 20),
                      
                        decoration: InputDecoration(
                           hintStyle:const TextStyle(fontSize: 18),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'enter nick name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                    
                      ),
                      const SizedBox(height: 10,),
                     TextFormField(
                      autofocus: true,
                       
                        keyboardType: TextInputType.text,
                         style:const TextStyle(fontSize: 20),
                      
                        decoration: InputDecoration(
                           hintStyle:const TextStyle(fontSize: 18),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'enter full name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                        // onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(focusNode1) ,
                      ),
                      const SizedBox(height: 20,),
                       TextFormField(
                        // focusNode: focusNode1,
                       autofocus: true,
                        keyboardType: TextInputType.number,
                         style:const TextStyle(fontSize: 20),
                        
                        decoration: InputDecoration(
                           hintStyle:const TextStyle(fontSize: 18),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'enter mobile number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      // onFieldSubmitted: (value) => FocusManager.instance.primaryFocus?.unfocus()
                      ),
                      
                       const SizedBox(height: 20,),
                     InkWell(
                      onTap: ()=>Get.to(const PinSetUp()),
                       child: const  Chip(
                        backgroundColor: Colors.white,
                        padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          label: Text('Next'),
                          labelStyle: TextStyle(
                            color:  ThemeColors.background,
                            fontSize: 26
                          ),
                         ),
                     ),
                     const SizedBox(height: 20,),
                     RichText(text: TextSpan(
                      children: [
                      const  TextSpan(text: "Already have an account? ",style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        )),
                            TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = 
                              ()=> Get.to(const LoginPage()),
                              text: 'Login',style:const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ))
                      ]
                     ))
                            
                    ],
                  ),
                )
           ],
          ),
        ),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: const Mic()),
        ),
      ),
    );

  }
}

