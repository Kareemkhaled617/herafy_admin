import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/home_page.dart';

void addCenterData({
  email,
  pass,
  name,
  type,
  phone,
  address,
  late,
  long,
  profile,
  img1,
  img2,
  img3,
  color,
  icon,
  open,
  availability,
  uid,
}) {
  FirebaseFirestore.instance.collection('hospital').doc(uid).set({
    'email': email,
    'name': name,
    'type': type,
    'phone': phone,
    'address': address,
    'late': late,
    'long': long,
    'profile': profile,
    'color': color,
    'icon': icon,
    'image': [img1, img2, img3],
    'open': open,
    'availability': availability,
    'date': DateTime.now(),
    'uid': uid,
  });
}



Future login1(String email, pass, {context}) async {
  print(email);
  print(pass);
  try {
    if (email.isNotEmpty && pass.isNotEmpty) {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      // print(userCredential);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HomePage()));
      return userCredential;
    } else {
      print('isEmpty');
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Attend  !',
        desc: 'This Account IsNot Exist',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    } else if (e.code == 'wrong-password') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Attend  !',
        desc: 'The password is Wrong',
        btnOkOnPress: () {},
      ).show();
    }
  } catch (e) {
    print(e);
  }
}

Future getServicesData() async {
  var fireStore = FirebaseFirestore.instance;
  QuerySnapshot qn = await fireStore.collection("allService").get();
  return qn.docs;
}

updateData({
  email,
  name,
  type,
  phone,
  address,
  late,
  long,
  profile,
  img1,
  img2,
  img3,
  color,
  icon,
  open,
  availability,
  uid,
}) {
  FirebaseFirestore.instance.collection('hospital').doc(uid).update(
    {
      'email': email,
      'name': name,
      'type': type,
      'phone': phone,
      'address': address,
      'late': late,
      'long': long,
      'profile': profile,
      'color': color,
      'icon': icon,
      'image': [img1, img2, img3],
      'open': open,
      'availability': availability,
      'date': DateTime.now(),
      'uid': uid,
    },
    // SetOptions(merge: true),
  );
}

delete(String uid) {
  FirebaseFirestore.instance.collection('hospital').doc(uid).delete();
}
