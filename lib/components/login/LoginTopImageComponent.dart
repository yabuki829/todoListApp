import 'package:flutter/material.dart';

class LoginTopImageComponent extends StatelessWidget {
  const LoginTopImageComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10 * 2),
        const Text(
          "LOGIN",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset("images/login.png"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 10 * 2),
      ],
    );
  }
}
