import 'package:avatar_glow/avatar_glow.dart';
import 'package:bank/constants/constants.dart';
import 'package:bank/views/features/home/home.dart';
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

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 
  @override
  Widget build(BuildContext context) {
 bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
 final focusNode = FocusNode();
    final formKey = GlobalKey<FormState>();
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
    return  GestureDetector(
       onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ThemeColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Center(
               child: SizedBox(
                width: MediaQuery.of(context).size.width*0.9,
                child: Image.asset(Images.loginbanner)),
               
                ),
                const Text('Login',style: TextStyle(
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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                         keyboardType: TextInputType.number,
                         style:const TextStyle(fontSize: 20),
                        autofocus: true,
                        decoration: InputDecoration(
                           hintStyle:const TextStyle(fontSize: 18),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Email Id',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                        onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(focusNode) ,
                      ),
                    const SizedBox(height: 20,),
                      Pinput(
                        closeKeyboardWhenCompleted: true,
                        obscureText: true,
                        length: 6,
                        focusNode: focusNode,
                        defaultPinTheme: defaultPinTheme,
                        validator: (value) {
                          return value == '123456' ? null : 'Pin is incorrect';
                        },
                       
                        onChanged: (value) {
                        print(value);
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: focusedBorderColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(19),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyWith(
                          textStyle: TextStyle(color: Colors.redAccent,fontSize: 32),
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(19),
                            border: Border.all(color: Colors.redAccent,width: 3),
                          ),
                        ),
                      ),
                       const SizedBox(height: 20,),
                     InkWell(
                       onTap: ()=>Get.to(const Home()),
                       child: const  Chip(
                        backgroundColor: Colors.white,
                        padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          label: Text('Login'),
                          labelStyle: TextStyle(
                            color:  ThemeColors.background,
                            fontSize: 26
                          ),
                         ),
                     ),
                     const SizedBox(height: 20,),
                     RichText(text: TextSpan(
                      children: [
                      const  TextSpan(text: "Don't have an account? ",style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        )),
                            TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = 
                              ()=> Get.to(const SignUpPage()),
                              text: 'Register',style:const TextStyle(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: const Mic()),
      ),
    );

  }
}

