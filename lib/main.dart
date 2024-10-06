import 'package:flutter/material.dart';
import 'package:todoapp/notifier/theme_notifier.dart';
import 'package:todoapp/routers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/utils/share_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await SharedPreferencesInstance.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: '目標を達成するためのToDoリスト',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      themeMode: ref.watch(themeModeNotifierProvider),
      darkTheme: ThemeData.dark(),
    );
  }
}
