import 'package:flutter/material.dart';
import 'package:todoapp/widget/login/LoginForm.dart';
import 'package:todoapp/widget/login/LoginTopImageComponent.dart';

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoginTopImageComponent(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(),
            ),
            Spacer(),
          ],
        ),
        SizedBox(
          height: 120,
          width: 120,
        )
      ],
    );
  }
}
