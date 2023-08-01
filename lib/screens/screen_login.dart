import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/functions/login_functions.dart';
import 'package:travelapp/functions/validator_functions.dart';
import 'package:travelapp/screens/screen_signup.dart';
import 'package:travelapp/wigets/text_fields/buttons/button_login.dart';
import 'package:travelapp/wigets/text_fields/text_form_field.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});

  final formlog = GlobalKey<FormState>();

  final emailControl = TextEditingController();

  final passwordControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/trlwlp5.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              addVerticalSpace(100),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Explore With \nTrip Planner . .',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                // height: SCREEN_HEIGHT * 0.55,
                padding: const EdgeInsets.all(40),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(40),
                    topStart: Radius.circular(40),
                  ),
                  // color: Color.fromARGB(100, 80, 126, 244),
                ),
                child: Form(
                  key: formlog,
                  child: Column(
                    children: [
                      Column(children: [
                        addVerticalSpace(27),
                        FormFields(
                          textContol: emailControl,
                          textLabel: 'email . . .',
                          function: isValidEmail,
                        ),
                        addVerticalSpace(27),
                        FormFields(
                          textContol: passwordControl,
                          textLabel: 'password . . .',
                          obscure: true,
                          function: isValidPassword,
                        ),
                        addVerticalSpace(27),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              LogAuth.checkSignIn(
                                context: context,
                                formlog: formlog,
                                email: emailControl.text.trim(),
                                password: passwordControl.text.trim(),
                              );
                            },
                            child: ButtonContainer(
                              textIn: 'sign-in. . .',
                              visibleIcon: true,
                              icon: const Icon(Icons.arrow_circle_up_rounded),
                            ),
                          ),
                        ),
                        addVerticalSpace(17),
                        Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'Don\'t have an account? ',
                                style: TextStyle(color: whiteSecondary),
                              ),
                              TextButton(
                                style: const ButtonStyle(
                                    overlayColor: MaterialStatePropertyAll(
                                        whiteSecondary)),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ScreenSignup(),
                                      ),
                                      (route) => false);
                                },
                                child: const Text(
                                  'sign-up',
                                  style: TextStyle(color: bluePrimary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
