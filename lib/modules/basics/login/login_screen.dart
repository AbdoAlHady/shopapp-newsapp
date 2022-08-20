import 'package:bmicalc/shared/components/component.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "LogIn",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  defaultFormField(
                      prefix: Icons.email,
                      isPassword: false,
                      label: "Email Address",
                      type: TextInputType.emailAddress,
                      controller: emailController,
                      validate: (value) {
                        if (value.isEmpty) {
                          return "Email Must Not Be Empty";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                      prefix: Icons.lock,
                      sufix:
                          isPassword ? Icons.visibility : Icons.visibility_off,
                      isPassword: isPassword,
                      label: "Password",
                      type: TextInputType.visiblePassword,
                      controller: passwordController,
                      sufixPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      validate: (value) {
                        if (value.isEmpty) {
                          return "Password Must Not Be Empty";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultButton(
                      text: "login",
                      background: Colors.blue,
                      function: () {
                        if (formKey.currentState!.validate()) {
                          print(emailController.text);
                          print(passwordController.text);
                        }
                      },
                      width: double.infinity,
                      raduis: 20),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultButton(
                      text: "Register",
                      background: Colors.red,
                      function: () {},
                      width: double.infinity,
                      isUpperCase: false),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Register now",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
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
