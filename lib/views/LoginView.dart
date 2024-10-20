import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/notifier/backend/auth_provider.dart';
import 'package:todoapp/routers.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  var isShowPassword = true;
  var emailText = "";
  var passwordText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Consumer(builder: (context, ref, child) {
        return Center(
          child: Container(
            width: 600,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'ログイン',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: (value) {
                    emailText = value;
                  },
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'sample@example.com',
                    labelText: 'メールアドレス',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'メールアドレスを入力してください';
                    }
                    if (!value.contains('@')) {
                      return 'メールアドレスが不正です';
                    }
                    return null;
                  },
                  autofillHints: const [AutofillHints.email],
                ),
                TextFormField(
                  onChanged: (value) {
                    passwordText = value;
                  },
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  obscureText: isShowPassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'パスワード',
                    suffixIcon: IconButton(
                      icon: isShowPassword
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'パスワードを入力してください';
                    }
                    return null;
                  },
                  autofillHints: const [AutofillHints.password],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  autofocus: true,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final asyncValue = ref.read(authProvider.notifier).login(
                            email: emailText,
                            password: passwordText,
                          );
                      asyncValue.then((isLogin) {
                        print(isLogin);
                        if (isLogin) {
                          router.go("/");
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              title: const Text('ログイン失敗'),
                            ),
                          );
                        }
                      });
                    }
                  },
                  child: const Text('ログイン'),
                ),
              ],
            ),
          ),
        );
      }),
    ));
  }
}
