import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/controller/firebase/cred_firebase_admin_operations.dart';

import '../../../controller/functions/login_functions.dart';
import '../../../controller/functions/user_detail/user_detail_taker.dart';
import '../DialogeTerms/termsdialoge.dart';
import '../text_fields/buttons/button_login.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key, required this.scaffoldkey});

  final GlobalKey<ScaffoldState> scaffoldkey;

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  ReposatoryDestination reposatoryDestination = ReposatoryDestination();
  User? currentUser = currentUserDetail();

  _onShare(context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share('https://play.google.com/store/apps/details?id=com.waywizard.travello',
        subject: '',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: whitePrimary,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/catogorybackground/forestforcatogory.jpg'))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addVerticalSpace(20),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          widget.scaffoldkey.currentState!.closeDrawer();
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                        color: whiteSecondary,
                        iconSize: 30,
                      ),
                    ),
                    addVerticalSpace(20),
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: whiteSecondary,
                              borderRadius: BorderRadius.circular(50)),
                          height: SCREEN_WIDTH * 0.25,
                          width: SCREEN_WIDTH * 0.25,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(currentUser!.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              return !snapshot.hasData ||
                                      snapshot.data!.get('profileimg') == '' ||
                                      snapshot.data!.get('profileimg').isEmpty
                                  ? Center(
                                      child: Text(
                                        currentUser!.email
                                            .toString()
                                            .toUpperCase()
                                            .substring(0, 1),
                                        style: TextStyle(
                                          fontSize: SCREEN_WIDTH * 0.25,
                                          color: blueSecondary,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                              blurRadius: 1,
                                              spreadRadius: 1,
                                              color: whiteSecondary)
                                        ],
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              snapshot.data!.get('profileimg'),
                                            ),
                                            fit: BoxFit.cover),
                                      ),
                                    );
                            },
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 10,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(127, 75, 86, 115),
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                              onPressed: () async {
                                XFile? img = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (img != null) {
                                  await reposatoryDestination.uploadProfile(
                                      img, currentUser!.uid);
                                }
                              },
                              icon: const Icon(
                                Icons.photo_camera_outlined,
                                size: 15,
                                color: whiteSecondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              addVerticalSpace(20),
              ButtonContainer(
                textIn:
                    currentUser != null ? currentUser!.email! : 'travello User',
                size: 20,
                height: 40,
                color: whiteSecondary,
              ),
              const Divider(),
              ButtonContainer(
                textIn: 'Privacy Policy',
                size: 20,
                height: 40,
                // width: 90,
                color: whiteSecondary,
                visibleIcon: true,
                icon: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsDialog(
                            headline: 'Privacy Policy',
                            fileName: 'privacy_policy.txt'),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.shield_outlined,
                  ),
                ),
              ),
              const Divider(),
              ButtonContainer(
                textIn: 'Terms & Conditions',
                size: 20,
                height: 40,
                // width: 90,
                color: whiteSecondary,
                visibleIcon: true,
                icon: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TermsDialog(
                              headline: 'Terms & Conditions',
                              fileName: 'terms_and_conditions.txt'),
                        ));
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ),
              const Divider(),
              ButtonContainer(
                textIn: 'share',
                size: 20,
                height: 40,
                // width: 90,
                color: whiteSecondary,
                visibleIcon: true,
                icon: IconButton(
                  onPressed: () {
                    _onShare(context);
                  },
                  icon: const Icon(
                    Icons.share_outlined,
                  ),
                ),
              ),
              const Divider(),
              ButtonContainer(
                textIn: 'Log-out',
                size: 20,
                height: 40,
                // width: 110,
                color: whiteSecondary,
                visibleIcon: true,
                icon: IconButton(
                  onPressed: () {
                    showDialogeBox(context);
                  },
                  icon: const Icon(
                    Icons.logout,
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const Text(
                'Version 0.1',
                style: TextStyle(fontSize: 20, color: blueSecondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

showDialogeBox(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        'are you sure want to logout',
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('cancel')),
        TextButton(
            onPressed: () {
              LogAuth.signOut(context);
            },
            child: const Text('logout'))
      ],
    ),
  );
}
