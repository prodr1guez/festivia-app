import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateParse {
  String DiaConMes(DateTime date) {
    initializeDateFormatting('es_ES', null);
    final dateTime = DateTime.parse(date.toString());
    final DateString = DateFormat.MMMMd('es_AR').format(dateTime);
    return DateString;
  }

  String DiaConHora(DateTime date) {
    initializeDateFormatting('es_ES', null);
    final dateTime = DateTime.parse(date.toString());
    final DateString = DateFormat.MMMMd('es_AR').format(dateTime);
    final HourString = Hora(date);
    String finalDATE = DateString + " " + HourString;
    return finalDATE;
  }

  String DiaConMesYAno(DateTime date) {
    initializeDateFormatting('es_ES', null);
    final dateTime = DateTime.parse(date.toString());
    final DateString = DateFormat.MMMMd('es_AR').format(dateTime);
    return DateString;
  }

  String Hora(DateTime date) {
    initializeDateFormatting('es_ES', null);
    final dateTime = DateTime.parse(date.toString());
    final formatTime = DateFormat('HH:mm a');
    final clockString = formatTime.format(dateTime);
    return clockString;
  }

  String CompareDate(String date) {
    DateTime valEnd = DateTime.parse(date);
    DateTime dateNow = DateTime.now();
    bool isFinished = valEnd.isBefore(dateNow);
    if (isFinished) {
      return "notAvailable";
    }
    return "available";
  }

  bool isStarted(String date) {
    DateTime valStart = DateTime.parse(date);
    DateTime dateNow = DateTime.now();
    return dateNow.isAfter(valStart);
  }

  bool isFinished(String date) {
    DateTime valEnd = DateTime.parse(date);
    DateTime dateNow = DateTime.now();
    return valEnd.isBefore(dateNow);
  }

  CompareDateBool(String date) {
    DateTime valEnd = DateTime.parse(date);
    DateTime dateNow = DateTime.now();
    bool isFinished = valEnd.isBefore(dateNow);
    if (isFinished) {
      return false;
    }
    return true;
  }
}
