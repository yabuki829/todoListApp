import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/notifier/theme_notifier.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "設定",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final toggle = ref.read(themeModeNotifierProvider.notifier).toggle;
          switch (ref.watch(themeModeNotifierProvider)) {
            case ThemeMode.light:
              return ListTile(
                leading: const Icon(Icons.light_mode_rounded),
                title: const Text('ライトモード'),
                onTap: toggle,
              );
            case ThemeMode.dark:
              return ListTile(
                leading: const Icon(Icons.dark_mode_rounded),
                title: const Text('ダークモード'),
                onTap: toggle,
              );
            case ThemeMode.system:
              return ListTile(
                leading: const Icon(Icons.smartphone_rounded),
                title: const Text('システムの設定に合わせる'),
                onTap: toggle,
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
