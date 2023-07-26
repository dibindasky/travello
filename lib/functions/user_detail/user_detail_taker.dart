import 'package:firebase_auth/firebase_auth.dart';

User? currentUserDetail(){
  return FirebaseAuth.instance.currentUser;
} 