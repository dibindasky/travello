import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

 
// setLogin({required String email, required String password,required BuildContext context}) async {
//   // SharedPreferences pref=await SharedPreferences.getInstance();
//   // pref.setBool('login', true);
//   showDialog(context: context,barrierDismissible: false,builder: (context)=>Center(child: CircularProgressIndicator(),));
//   try {
//     await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password);
//   }on FirebaseAuthException catch (e){
//     if (e.code == 'user-not-found' || e.code == 'wrong-password') {
//           errorMsg= 'Email or password not found';
//       } else {
//           errorMsg= 'An error occurred, please try again later';
//       }
//   }
//   navigatorKey.currentState!.popUntil((route) => route.isFirst);
// }

Future<bool> getLogin() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool log = pref.getBool('login') ?? false;
  return log;
}

void clearLogin() async {
  // SharedPreferences pref=await SharedPreferences.getInstance();
  // pref.remove('login');
  await FirebaseAuth.instance.signOut();
}
