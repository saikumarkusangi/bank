import 'package:bank/constants/constants.dart';
import 'package:bank/controllers/user_controller.dart';
import 'package:bank/views/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../widgets/widgets.dart';

class SendPage extends StatefulWidget {
  const SendPage({super.key});

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  int _ammount = 0;
  String to = '';
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    @override
    final provider = Provider.of<UserController>(context);
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: ThemeColors.secondary,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 32),
        backgroundColor: ThemeColors.green,
        elevation: 0,
        //title:const Text('Send money to',style: TextStyle(color: ThemeColors.primary),),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: (provider.isLoading)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 100,
                          child: Column(children: [
                            const Text(
                              'Send money to',
                              style: TextStyle(
                                  color: ThemeColors.primary,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                // Text(
                                //   'sai kumae',
                                //   style: TextStyle(
                                //       color: Colors.black, fontSize: 28),
                                // ),
                              ],
                            ),
                            TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  to = val;
                                });
                              },
                              keyboardType: TextInputType.text,
                              style: const TextStyle(fontSize: 20),
                              autofocus: true,
                              decoration: InputDecoration(
                                  hintStyle: const TextStyle(fontSize: 18),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'enter recevier name',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              //  onFieldSubmitted: (value) =>
                              //  FocusScope.of(context).requestFocus(focusNode),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter recevier name';
                                }
                              },
                            ),
                          ])),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.2),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    _ammount = int.parse(value);
                                  });
                                },
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.black87,
                                style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 62,
                                ),
                                decoration: const InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    prefix: Text(
                                      '₹',
                                      style: TextStyle(
                                          fontSize: 62,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    border: InputBorder.none,
                                    hintText: '0',
                                    hintStyle: TextStyle(
                                        fontSize: 62,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          //  print(_ammount.text);
                          if (to.isNotEmpty) {
                            print(to);
                            print(_ammount);
                            String response = await provider.send(
                                from: 'sandeep', to: to, ammount: _ammount);
                            // await provider.userdatafetch();
                            print(response);
                            if (response == ' success') {
                              Get.snackbar('Success', "Money successfully sent",
                                  snackPosition: SnackPosition.TOP);
                              await provider.userdatafetch();
                              Get.to(const Home());
                            } else {
                              Get.snackbar(
                                  'Something went wrong',
                                  response
                                      .toString()
                                      .split(',')[1]
                                      .split(":")[1],
                                  snackPosition: SnackPosition.TOP);
                            }
                          }
                        },
                        color: ThemeColors.green,
                        child: const Text(
                          'Send',
                          style: TextStyle(color: Colors.black, fontSize: 28),
                        ),
                        minWidth: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                      )
                    ],
                  ),
                ),
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          Visibility(visible: !keyboardIsOpen, child: const Mic()),
    );
  }
}
