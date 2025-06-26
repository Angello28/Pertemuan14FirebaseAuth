import 'package:firebase_ti/controller/authservice.dart';
import 'package:firebase_ti/view/home.dart';
import 'package:firebase_ti/view/login.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignupPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool seePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.shopping_bag,
                color: Colors.white,
                size: 80,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Sign Up",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: "Username"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: "Email"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: seePassword,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          seePassword = !seePassword;
                        });
                      },
                      child: Icon(seePassword
                          ? Icons.visibility
                          : Icons.visibility_off)),
                  labelText: "Password"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final user = await AuthService().signUp(usernameController.text,
                    emailController.text, passwordController.text);
                if (user != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Sign Up berhasil")));
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Sign Up Gagal")));
                }
              },
              child: SizedBox(
                  width: 150,
                  child: Text(
                    "Sign up",
                    textAlign: TextAlign.center,
                  )),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final user = await AuthService().signInWithGoogle();
                if (user != null) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Login berhasil")));
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomePage(
                            user: user,
                          )));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Login gagal")));
                }
              },
              child: SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                          height: 20,
                          image: NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png")),
                      Text(
                        "Sign up with Google",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Text("Already have an account?"),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: SizedBox(
                  width: 150,
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                  )),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
