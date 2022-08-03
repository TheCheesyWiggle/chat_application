import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future signInFunction() async {
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return;
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    DocumentSnapshot userExist =
        await firestore.collection('users').doc(userCredential.user!.uid).get();
    if (userExist.exists) {
      print("USER EXISTS");
    } else {
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'name': userCredential.user!.displayName,
        'image': userCredential.user!.photoURL,
        'uid': userCredential.user!.uid,
        'date': DateTime.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(
                    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fpreviews%2F000%2F599%2F837%2Foriginal%2Fspeech-bubble-chat-icon-logo-template-vector.jpg&f=1&nofb=1"),
              )),
            ),
          ),
          const Text(
            "Flutter WhatsApp Clone",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: ElevatedButton(
              onPressed: () async {
                await signInFunction();
              },
              child: Row(
                children: [
                  Image.network(
                      "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fpluspng.com%2Fimg-png%2Fgoogle-logo-png-open-2000.png&f=1&nofb=1",
                      height: 36),
                  const SizedBox(width: 10),
                  const Center(
                    child: Text(
                      "Sign In With Google",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 1)),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
