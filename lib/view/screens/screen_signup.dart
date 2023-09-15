import 'package:flutter/material.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/view/screens/screen_login.dart';

import '../../controller/functions/login_functions.dart';
import '../../controller/functions/validator_functions.dart';
import '../wigets/text_fields/buttons/button_login.dart';
import '../wigets/text_fields/text_form_field.dart';

class ScreenSignup extends StatelessWidget {
  ScreenSignup({super.key});

  final formsignup = GlobalKey<FormState>();
  final nameSignupControl = TextEditingController();
  final passwordSignupControl = TextEditingController();
  final emailSignupControl = TextEditingController();

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
              addVerticalSpace(1),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Join Us . .',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(40),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(40), topStart: Radius.circular(40)),
                ),
                child: Form(
                  key: formsignup,
                  child: Column(
                    children: [
                      addVerticalSpace(25),
                      FormFields(
                        textContol: nameSignupControl,
                        textLabel: 'name . . .',
                        function: isAlphabet,
                      ),
                      addVerticalSpace(25),
                      FormFields(
                        textContol: emailSignupControl,
                        textLabel: 'email id . . .',
                        function: isValidEmail,
                      ),
                      addVerticalSpace(25),
                      FormFields(
                        textContol: passwordSignupControl,
                        textLabel: 'password . . .',
                        obscure: true,
                        function: isValidPassword,
                      ),
                      addVerticalSpace(25),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            if (formsignup.currentState!.validate()) {
                              LogAuth.addUser(
                                  email: emailSignupControl.text.trim(),
                                  password: passwordSignupControl.text.trim(),
                                  name: nameSignupControl.text.trim(),
                                  context: context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScreenLogin(),
                                  ));
                            }
                          },
                          child: ButtonContainer(
                            textIn: 'sign-up',
                            visibleIcon: true,
                            icon: const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScreenLogin(),
                                ),
                                (route) => false);
                          },
                          label: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                          ),
                          icon: const Text('sign-in'),
                        ),
                      )
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
