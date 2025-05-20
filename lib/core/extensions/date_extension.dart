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

  String get timeOrDateofMessage {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(year, month, day);
    final diff = today.difference(date).inDays;

    if (diff == 0) {
      // today
      return DateFormat('hh:mm a').format(this);
    } else if (diff == 1) {
      // yesterday
      return 'Yesterday';
    } else {
      // other date
      return DateFormat('yyyy-MM-dd').format(this);
    }
  }

  String get toReadableTime {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes == 1) {
      return '1 minute ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours == 1) {
      return '1 hour ago';
    } else if (difference.inHours <= 2) {
      return '${difference.inHours} hours ago';
    } else if (_isYesterday(this, now)) {
      return 'Yesterday at ${DateFormat('hh:mm a').format(this)}';
    } else {
      return DateFormat('hh:mm a').format(this);
    }
  }

  static bool _isYesterday(DateTime date, DateTime now) {
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }
}
