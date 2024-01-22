import 'package:intl/intl.dart';

class StringUtils {
  static final emailRegex = RegExp(
    r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );

  static String formatDate(date) {
    return DateFormat.yMd().format(date);
  }
}
