import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:learn_flutter/constants/constants.dart';
import 'package:learn_flutter/pages/Login/signin.dart';
import 'package:learn_flutter/services/auth.dart';
import 'package:learn_flutter/widgets/button.dart';
import 'package:learn_flutter/widgets/textfield.dart';
import 'package:page_transition/page_transition.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signUpWithEmailPassword() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      if (_passwordController.text == _emailController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
      } else {
        showErrorMessage('Password do not match');
      }
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignIn()));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: white,
            title: Center(
                child: Text(
              message,
              style:
                  TextStyle(fontFamily: 'Gilmer', color: black, fontSize: 14),
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Icon(
          Icons.arrow_back,
          color: black,
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: padding,
                    right: padding,
                  ),
                  child: Text(
                    "Sign Up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Gilmer',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: black,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.fromLTRB(padding, 0, padding, padding),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Gilmer',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                child: Column(
                  children: [
                    MyTextField(
                      controller: _nameController,
                      hintText: 'Name',
                      icon: IconlyLight.add_user,
                      isObscure: false,
                      type: TextInputType.name,
                      labelText: '',
                    ),
                    const SizedBox(
                      height: 0.0,
                    ),
                    MyTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      icon: IconlyLight.message,
                      isObscure: false,
                      type: TextInputType.emailAddress,
                      labelText: '',
                    ),
                    MyTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      icon: IconlyLight.call,
                      isObscure: true,
                      type: TextInputType.text,
                      labelText: '',
                    ),
                    MyTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      icon: IconlyLight.password,
                      isObscure: true,
                      type: TextInputType.text,
                      labelText: '',
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    MyButton(
                      text: 'Sign Up',
                      background: black,
                      foreground: white,
                      onTap: () {
                        signUpWithEmailPassword();
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Checkbox(
                              overlayColor: MaterialStateProperty.all(black),
                              side: BorderSide(color: black, width: 2),
                              value: false,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onChanged: (value) {},
                            ),
                          ),
                          Text(
                            'I agree to the ',
                            style: TextStyle(
                                fontFamily: 'Gilmer',
                                fontSize: 14,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                                color: black),
                          ),
                          Text(
                            'terms & conditions',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: 'Gilmer',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: black,
                            ),
                          ),
                          Text(
                            ' and ',
                            style: TextStyle(
                                fontFamily: 'Gilmer',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: black),
                          ),
                          Text(
                            'policy.',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontFamily: 'Gilmer',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Or Sign up using',
                      style: TextStyle(
                          fontFamily: 'Gilmer',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: black),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () => AuthService().signInWithGoogle(),
                            child: socialMedia('assets/images/google.png')),
                        socialMedia('assets/images/facebook.png'),
                        socialMedia('assets/images/email.png'),
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                              fontFamily: 'Gilmer',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(PageTransition(
                                child: const SignIn(),
                                type: PageTransitionType.fade));
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                fontFamily: 'Gilmer',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget socialMedia(url) {
  return Padding(
    padding: const EdgeInsets.only(left: 30, right: 30.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            url,
            height: 20,
            width: 20,
          ),
        ),
      ),
    ),
  );
}
