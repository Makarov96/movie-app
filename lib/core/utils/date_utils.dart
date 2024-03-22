// ...

import 'package:mobile_dependencies/mobile_dependencies.dart';

final class DateTimeFormatter {
  const DateTimeFormatter._();
  static String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
}
