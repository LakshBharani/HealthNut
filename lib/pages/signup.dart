// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:healthnut/pages/home.dart';
import 'package:healthnut/pages/login.dart';
import 'package:healthnut/services/auth_service.dart';
import 'package:healthnut/shared/loading.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password1_controller = TextEditingController();
  TextEditingController password2_controller = TextEditingController();
  bool isPwdHidden = true;
  bool loading = false;

  bool validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset('lib/assets/banner.png'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                              ),
                            ),
                            Text(
                              '.',
                              style: TextStyle(
                                  fontSize: 50, color: Colors.deepPurple),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Create Account ',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              value!.isEmpty || !validateEmail(value)
                                  ? 'Invalid email'
                                  : null,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: "Email",
                          ),
                          controller: email_controller,
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          obscureText: isPwdHidden,
                          validator: (val) => val!.length < 6
                              ? 'Password must contain 6 or more characters'
                              : null,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffix: GestureDetector(
                              child: Icon(
                                isPwdHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: isPwdHidden
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),
                              onTap: () {
                                setState(() {
                                  isPwdHidden = !isPwdHidden;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: "Password",
                          ),
                          controller: password1_controller,
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          obscureText: isPwdHidden,
                          validator: (val) => password1_controller.text !=
                                  password2_controller.text
                              ? "Passwords don't match"
                              : null,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffix: GestureDetector(
                              child: Icon(
                                isPwdHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: isPwdHidden
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),
                              onTap: () {
                                setState(() {
                                  isPwdHidden = !isPwdHidden;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: "Confirm Password",
                          ),
                          controller: password2_controller,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Creating an account means you're okay with our Terms of Serivces and our Privacy Policy",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await context
                                    .read<AuthenticationProvider>()
                                    .signUp(
                                      email: email_controller.text.trim(),
                                      password:
                                          password2_controller.text.trim(),
                                    );

                                if (result == false) {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                    );
                                    loading = false;
                                  });
                                  final snackBar = SnackBar(
                                    duration: const Duration(seconds: 10),
                                    content: const Text(
                                        'Email already in use. Please Login'),
                                    action: SnackBarAction(
                                      label: 'Dismiss',
                                      textColor: Colors.purple[100],
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                      },
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()),
                                  ).then((value) {
                                    setState(() {
                                      loading = false;
                                    });
                                  });
                                }
                              }
                            },
                            child: const Text(
                              'Get Started',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?"),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                '\tLogin',
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
