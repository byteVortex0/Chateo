import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String get formattedDateTime {
    final formattedDate = DateFormat('yyyy-MM-dd').format(this);
    final formattedTime = DateFormat('hh:mm a').format(this);

    return 'التاريخ: $formattedDate - الوقت: $formattedTime';
  }

  String get formattedDate {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get formattedTime {
    return DateFormat('hh:mm a').format(this);
  }

  String get dateOfDivider {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(year, month, day);
    final diff = today.difference(date).inDays;

    if (diff == 0) {
      return 'Today';
    } else if (diff == 1) {
      return 'Yesterday';
    } else if (diff < 7) {
      return DateFormat('EEEE').format(this);
    } else {
      return DateFormat('yyyy-MM-dd').format(this);
    }
  }
}
