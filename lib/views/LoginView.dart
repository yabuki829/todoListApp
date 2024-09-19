/*! bulma.io v0.9.4 | MIT License | github.com/jgthms/bulma */

import 'package:flutter/material.dart';
import 'package:todoapp/responsive.dart';
import 'package:todoapp/components/login/LoginMobileView.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String errorText = '';
  // 入力したメールアドレス・パスワード
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
   
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: const SingleChildScrollView(
      child: Responsive(
        mobile: MobileLoginScreen(),
        desktop: Text("デスクトップです"),
      ),
    ));
  }
}
