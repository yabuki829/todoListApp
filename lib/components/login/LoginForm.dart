import 'package:flutter/material.dart';
import 'package:todoapp/components/login/AllredyHaveAccounts.dart';
import 'package:todoapp/searvices/ApiAuth.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future login() async {
      await ApiAuth().login("test@test.com", "test", context);
      // await ApiAuth().getTest();
    }

    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              login();
            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
          const SizedBox(height: 10),
          AlreadyHaveAnAccountCheck(
            press: () {
              print("test");
            },
          ),
        ],
      ),
    );
  }
}
