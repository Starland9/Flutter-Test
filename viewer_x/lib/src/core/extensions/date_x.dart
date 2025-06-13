import 'package:intl/intl.dart';

extension DateX on DateTime {
  String get formatted {
    return DateFormat('dd MMM yyyy', 'fr_FR').format(this);
  }
}
