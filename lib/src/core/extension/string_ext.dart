import 'package:intl/intl.dart';

extension StringExt on String {
  List<String> splitHeight() {
    if (isEmpty) {
      return ['', ''];
    }
    return split('.');
  }

  List<String> splitBirthDate() {
    if (isEmpty) {
      return ['', '', ''];
    }
    return split('-');
  }

  String toMonthName() {
    var month = splitBirthDate()[1];
    switch (month) {
      case '1':
        return 'Jan';
      case '2':
        return 'Feb';
      case '3':
        return 'Mar';
      case '4':
        return 'Apr';
      case '5':
        return 'May';
      case '6':
        return 'Jun';
      case '7':
        return 'Jul';
      case '8':
        return 'Aug';
      case '9':
        return 'Sept';
      case '10':
        return 'Oct';
      case '11':
        return 'Nov';
      case '12':
        return 'Dec';
      default:
        return '';
    }
  }

  String toAge() {
    if (isEmpty) {
      return '';
    }
    var formatter = DateFormat('dd-MM-yyyy');
    var date = formatter.parse(this);
    var now = DateTime.now();
    var age = now.year - date.year;
    var month1 = now.month;
    var month2 = date.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      var day1 = now.day;
      var day2 = date.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age.toString();
  }

  int toIntAge() {
    if (isEmpty) {
      return 0;
    }
    var formatter = DateFormat('dd-MM-yyyy');
    var date = formatter.parse(this);
    var now = DateTime.now();
    var age = now.year - date.year;
    var month1 = now.month;
    var month2 = date.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      var day1 = now.day;
      var day2 = date.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  String toDateAndMonth() {
    if (isEmpty) {
      return '';
    }
    // parse the string to DateTime object
    var formatter = DateFormat('dd-MM-yyyy');
    var date = formatter.parse(this);
    // format the DateTime object to desired format and return
    return DateFormat('dd MMM').format(date);
  }

  String toTimeAmPm() {
    if (isEmpty) {
      return '';
    }
    // parse the string to DateTime object
    var formatter = DateFormat('HH:mm');
    var date = formatter.parse(this);
    // format the DateTime object to am/pm time format and return
    return DateFormat('hh:mm a').format(date);
  }

  DateTime toDateTime() {
    if (isEmpty) {
      return DateTime.now();
    }
    // parse the string to DateTime object
    var formatter = DateFormat('dd-MM-yyyy');
    var date = formatter.parse(this);
    // format the DateTime object to am/pm time format and return
    return date;
  }

  String toDayMonth() {
    // Convert the input string to a DateTime object
    DateTime date = DateTime.parse(this);

    // Define the day and month abbreviations
    List<String> dayAbbreviations = [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat'
    ];
    List<String> monthAbbreviations = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    // Get the day, month, and year components
    int day = date.day;
    int month = date.month;
    int year = date.year;

    // Format the output string
    String formattedDate =
        '${dayAbbreviations[date.weekday - 1]}, ${monthAbbreviations[month]} $day';

    return formattedDate;
  }

  // if the string length is more than 22 characters, then it will move to next line and again
  // if the length is more than 22 characters, then it will move to next line
  String toMultiLine() {
    if (isEmpty) {
      return '';
    }
    var str = this;
    var newStr = '';
    var count = 0;
    for (var i = 0; i < str.length; i++) {
      if (count == 22) {
        newStr = '$newStr\n';
        count = 0;
      }
      newStr = newStr + str[i];
      count++;
    }
    return newStr;
  }
}

extension DateTimeExt on DateTime {
  String toMessageTime() {
    // to utc to local time
    var localTime = toLocal();
    // format the DateTime object to am/pm time format and return
    return DateFormat('hh:mm a').format(localTime);
  }
}
