import 'package:intl/intl.dart';

class DateFormater {
  static String format(DateTime date) {
    return DateFormat('yyyy年M月d日HH時mm分').format(date);
  }

  static String formatHowManyDays(DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now);

    final days = diff.inDays;
    final hours = diff.inHours % 24;
    final minutes = diff.inMinutes % 60;

    if (days == 0) {
      if (hours == 0) {
        if (minutes == 0) {
          return '期限切れ';
        }
        return '残り${minutes}分';
      }
      return '残り${hours}時間${minutes}分';
    }
    return '残り${days}日';
  }
}
