import 'package:intl/intl.dart';

class DateFormater {
  static String format(DateTime date) {
    return DateFormat('yyyy年M月d日HH時mm分').format(date);

    // if (date.year == DateTime.now().year) {
    //   if (date.month == DateTime.now().month) {
    //     return DateFormat('M月d日HH時mm分').format(date);
    //   }
    //   return DateFormat('M月d日HH時mm分').format(date);
    // }
    // return DateFormat('yyyy年M月d日HH時mm分').format(date);
  }

  static String formatHowManyDays(DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now);
    final days = diff.inDays;
    if (days == 0) {
      if (diff.inHours == 0) {
        if (diff.inMinutes == 0) {
          return 'もうすぐ';
        }
        return '残り${diff.inMinutes}分';
      }
      return '残り${diff.inHours}時間${diff.inMinutes}分';
    }
    return '残り${days}日と${diff.inHours}時間${diff.inMinutes}分';
  }
}
