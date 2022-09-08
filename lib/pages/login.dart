// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:healthnut/pages/home.dart';
import 'package:healthnut/pages/signup.dart';
import 'package:healthnut/services/auth_service.dart';
import 'package:healthnut/shared/loading.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  bool isPwdHidden = true;
  bool loading = false;
  bool signUp = true;
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
                              'Login',
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
                        Row(
                          children: [
                            const Text(
                              'Welcome Back To ',
                              style: TextStyle(fontSize: 20),
                            ),
                            const Text(
                              'Health',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            'Nut'.text.xl4.bold.white.make().shimmer(
                                primaryColor: Vx.red800,
                                secondaryColor: Vx.orange400),
                          ],
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
                          validator: (value) => value!.isEmpty
                              ? 'Password must contain 6 or more characters'
                              : null,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: "Password",
                          ),
                          controller: password_controller,
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
                                  print(email_controller.text);
                                  print(password_controller.text);
                                  loading = true;
                                });
                                dynamic result = await context
                                    .read<AuthenticationProvider>()
                                    .signIn(
                                      email: email_controller.text.trim(),
                                      password: password_controller.text.trim(),
                                    );
                                if (result == false) {
                                  setState(() {
                                    loading = false;
                                  });
                                  final snackBar = SnackBar(
                                    duration: const Duration(seconds: 10),
                                    content: Row(
                                      children: const [
                                        Icon(
                                          Icons.circle_notifications,
                                          color: Colors.redAccent,
                                        ),
                                        Text(
                                            '\t\tIncorrect Email and Password'),
                                      ],
                                    ),
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
                                  ).whenComplete(() {
                                    setState(() {
                                      loading = false;
                                      print('Login Success');
                                    });
                                  });
                                }
                              }
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignupPage()),
                                );
                              },
                              child: const Text(
                                '\tSign Up',
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
