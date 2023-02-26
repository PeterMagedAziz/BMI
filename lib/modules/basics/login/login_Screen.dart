import 'package:bmi/shared/components/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();
  bool isPasswordShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  defaultTextFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validator: (value ) {
                      if (value != null) {
                        return 'Email must not be Empty';
                      }
                      return null;
                    },
                    label: 'Email',
                    prefix: Icons.email,
                    suffixPressed: () {},
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultTextFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value != null) {
                        return 'Password must not be Empty';
                      }
                      return null;
                    },
                    label: 'Password',
                    prefix: Icons.lock,
                    suffix: isPasswordShow ? Icons.visibility : Icons.visibility_off,
                    isPassword: isPasswordShow,
                    suffixPressed: () {
                      setState(() {
                        isPasswordShow = !isPasswordShow;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    radius: 5.0,
                    text: 'login',
                    function: () {
                      if (formkey.currentState!.validate()) {
                        print(emailController.text);
                        print(passwordController.text);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Register Now',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
