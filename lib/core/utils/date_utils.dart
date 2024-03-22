// ...

import 'package:mobile_dependencies/mobile_dependencies.dart';

final class DateTimeFormatter {
  const DateTimeFormatter._();
  static String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
}

extension DateTimeExtension on DateTime {
  String get yyyymmddFromat => DateFormat('yyyy-MM-dd').format(this);
}
