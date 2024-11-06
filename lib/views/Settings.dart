import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/notifier/theme_notifier.dart';
import 'package:todoapp/views/change_tab_order.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toggle = ref.read(themeModeNotifierProvider.notifier).toggle;
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
        body: Column(
          children: [
            _buildThemeModeTile(ref, toggle),
            ListTile(
              leading: const Icon(Icons.change_circle),
              title: const Text('タブの入れ替え'),
              onTap: () {
                showModalBottomSheet(
                    useRootNavigator: true,
                    context: context,
                    builder: (context) => const ChangeTabOrderView());
              },
            ),
          ],
        ));
  }

  Widget _buildThemeModeTile(WidgetRef ref, VoidCallback toggle) {
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
  }
}
