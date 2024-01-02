import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final codeControllerController = TextEditingController();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () async {
                  try {
                    var user =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    if (user.user != null) {
                      print(user.user!.email);
                    } else {
                      print("error");
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                color: Colors.amber,
                textColor: Colors.white,
                child: const Text("Login"),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () async {
                  try {
                    var user = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    if (user.user != null) {
                      print(user.user!.email);
                    } else {
                      print("error");
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                color: Colors.amber,
                textColor: Colors.white,
                child: const Text("Create Account"),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: "Phone",
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: phoneController.text,
                    timeout: const Duration(seconds: 30),
                    verificationCompleted: (phoneAuthCredential) async {
                      var user = await FirebaseAuth.instance
                          .signInWithCredential(phoneAuthCredential);

                      if (user.user != null) {
                        print("success ${user.user!.phoneNumber}");
                      }
                    },
                    verificationFailed: (error) {
                      print(error.toString());
                    },
                    codeSent: (verificationId, forceResendingToken) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: SizedBox(
                              height: 400,
                              width: 300,
                              child: Column(
                                children: [
                                  TextField(
                                    controller: codeControllerController,
                                    decoration: const InputDecoration(
                                        labelText: "Code"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      var credential =
                                          PhoneAuthProvider.credential(
                                        verificationId: verificationId,
                                        smsCode: codeControllerController.text,
                                      );

                                      var user = await FirebaseAuth.instance
                                          .signInWithCredential(credential);
                                      if (user.user != null) {
                                        print(
                                            "success ${user.user!.phoneNumber}");
                                      }
                                    },
                                    child: const Text("Verify Code"),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    codeAutoRetrievalTimeout: (verificationId) {
                      print("time out");
                    },
                  );
                },
                child: const Text("Sign in with phone number"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  var user = await signInWithGoogle();

                  if (user.user != null) {
                    print("success ${user.user!.email}");
                  }
                },
                child: const Text("Sign in with google"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
