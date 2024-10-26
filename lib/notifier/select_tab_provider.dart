import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_tab_provider.g.dart';

@riverpod
class SelectTab extends _$SelectTab {
  @override
  int build() {
    return 0;
  }

  void selectTab(int index) {
    state = index;
  }

  int get selectedIndex => state;
}
