import 'package:jiffy/jiffy.dart';


class DateFormatHelper {
  static bool _localeInitialized = false;


  static Future<void> initArabic() async {
    if (!_localeInitialized) {
      await Jiffy.setLocale('ar');
      _localeInitialized = true;
    }
  }




  static String fullDate(DateTime date) =>
      Jiffy.parseFromDateTime(date).yMMMMd;


  static String dayMonth(DateTime date) =>
      Jiffy.parseFromDateTime(date).format(pattern: 'd MMMM');


  static String monthYear(DateTime date) =>
      Jiffy.parseFromDateTime(date).format(pattern: 'MMMM y');


  static String numeric(DateTime date) =>
      Jiffy.parseFromDateTime(date).format(pattern: 'd/M/y');


  static String iso(DateTime date) =>
      Jiffy.parseFromDateTime(date).format(pattern: 'yyyy-MM-dd');


  static String withDayName(DateTime date) =>
      Jiffy.parseFromDateTime(date).yMMMMEEEEd;


  static String withTime(DateTime date) =>
      Jiffy.parseFromDateTime(date).format(pattern: 'd MMMM y - h:mm a');


  static String with24HourTime(DateTime date) =>
      Jiffy.parseFromDateTime(date).format(pattern: 'd MMMM y - HH:mm');


  static String verbose(DateTime date) =>
      Jiffy.parseFromDateTime(date).format(
        pattern: "d MMMM y 'الساعة' h:mm a",
      );


  static String shortMonth(DateTime date) =>
      Jiffy.parseFromDateTime(date).format(pattern: 'd MMM');


  static String monthAbbr(DateTime date) =>
      Jiffy.parseFromDateTime(date).format(pattern: 'MMM');


  static String dayName(DateTime date) =>
      Jiffy.parseFromDateTime(date).format(pattern: 'EEEE');


  static String shortDayName(DateTime date) =>
      Jiffy.parseFromDateTime(date).format(pattern: 'EEE');


  static String yearOnly(DateTime date) =>
      Jiffy.parseFromDateTime(date).year.toString();


  static String dayOnly(DateTime date) =>
      Jiffy.parseFromDateTime(date).dateTime.day.toString();


  static String monthNumber(DateTime date) =>
      Jiffy.parseFromDateTime(date).dateTime.month.toString();


  static String fromNow(DateTime date) =>
      Jiffy.parseFromDateTime(date).fromNow();


  static String between(DateTime date, DateTime other) =>
      Jiffy.parseFromDateTime(date).from(Jiffy.parseFromDateTime(other));


  static String custom(DateTime date, String pattern) =>
      Jiffy.parseFromDateTime(date).format(pattern: pattern);




  static String time12Hour(DateTime date) =>
      Jiffy.parseFromDateTime(date).format(pattern: 'h:mm a');


  static String time24Hour(DateTime date) =>
      Jiffy.parseFromDateTime(date).format(pattern: 'HH:mm');


  static String timeWithSeconds(DateTime date) =>
      Jiffy.parseFromDateTime(date).format(pattern: 'h:mm:ss a');



  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static bool isThisWeek(DateTime date) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 6));
    return date.isAfter(weekStart.subtract(const Duration(seconds: 1))) &&
        date.isBefore(weekEnd.add(const Duration(days: 1)));
  }

  static bool isThisMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  static bool isThisYear(DateTime date) =>
      date.year == DateTime.now().year;

  static bool isPast(DateTime date) => date.isBefore(DateTime.now());

  static bool isFuture(DateTime date) => date.isAfter(DateTime.now());

  static bool isWeekend(DateTime date) =>
      date.weekday == DateTime.friday || date.weekday == DateTime.saturday;



  static DateTime addDays(DateTime date, int days) =>
      Jiffy.parseFromDateTime(date).add(days: days).dateTime;

  static DateTime subtractDays(DateTime date, int days) =>
      Jiffy.parseFromDateTime(date).subtract(days: days).dateTime;

  static DateTime addMonths(DateTime date, int months) =>
      Jiffy.parseFromDateTime(date).add(months: months).dateTime;

  static DateTime subtractMonths(DateTime date, int months) =>
      Jiffy.parseFromDateTime(date).subtract(months: months).dateTime;

  static DateTime addYears(DateTime date, int years) =>
      Jiffy.parseFromDateTime(date).add(years: years).dateTime;

  static DateTime startOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static DateTime endOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day, 23, 59, 59);

  static DateTime startOfMonth(DateTime date) =>
      DateTime(date.year, date.month, 1);

  static DateTime endOfMonth(DateTime date) =>
      DateTime(date.year, date.month + 1, 0);

  static DateTime startOfYear(DateTime date) =>
      DateTime(date.year, 1, 1);

  static DateTime endOfYear(DateTime date) =>
      DateTime(date.year, 12, 31);



  static int ageInYears(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }


  static int differenceInDays(DateTime a, DateTime b) =>
      a.difference(b).inDays.abs();


  static int differenceInHours(DateTime a, DateTime b) =>
      a.difference(b).inHours.abs();


  static int differenceInMinutes(DateTime a, DateTime b) =>
      a.difference(b).inMinutes.abs();



  static DateTime? tryParse(String dateString, {String? pattern}) {
    try {
      if (pattern != null) {
        return Jiffy.parse(dateString, pattern: pattern).dateTime;
      }
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  static DateTime parseOrNow(String dateString, {String? pattern}) {
    return tryParse(dateString, pattern: pattern) ?? DateTime.now();
  }


  static List<DateTime> sortAscending(List<DateTime> dates) {
    final sorted = List<DateTime>.from(dates);
    sorted.sort((a, b) => a.compareTo(b));
    return sorted;
  }


  static List<DateTime> sortDescending(List<DateTime> dates) {
    final sorted = List<DateTime>.from(dates);
    sorted.sort((a, b) => b.compareTo(a));
    return sorted;
  }


  static List<DateTime> filterToday(List<DateTime> dates) =>
      dates.where(isToday).toList();


  static List<DateTime> filterFuture(List<DateTime> dates) =>
      dates.where(isFuture).toList();


  static List<DateTime> filterPast(List<DateTime> dates) =>
      dates.where(isPast).toList();




  static String smartLabel(DateTime date) {
    if (isToday(date)) return 'اليوم';
    if (isYesterday(date)) return 'أمس';
    if (isTomorrow(date)) return 'غداً';
    return fullDate(date);
  }


  static String smartLabelWithTime(DateTime date) {
    final time = time12Hour(date);
    if (isToday(date)) return 'اليوم $time';
    if (isYesterday(date)) return 'أمس $time';
    if (isTomorrow(date)) return 'غداً $time';
    return '${fullDate(date)} $time';
  }
}