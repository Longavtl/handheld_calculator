import 'package:intl/intl.dart';

class ConvertUtils {
  static String hiddenPhone(String str) {
    if (str == null) {
      return '';
    }
    if ((str != null || str != '') && str.length > 8) {
      return '${str.substring(0, 3)}***${str.substring(str.length - 4, str.length)}';
    } else {
      return '';
    }
  }

  static String hideEmail(String email) {
    if (email?.isEmpty ?? true) {
      return '';
    }

    final parts = email.split('@');
    final username = parts[0];
    final hiddenPart = '*' * (username.length - 3);

    return '${username.substring(0, 3)}$hiddenPart@${parts[1]}';
  }

  static String hiddenIdCard(String input) {
    if (input.length <= 5) {
      return input;
    }

    return '*' * (input.length - 5) + input.substring(input.length - 5);
  }

  static String formatCurrency(int value) {
    return value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.');
  }

  static dynamic ConvertNumZero(num value) {
    if (value == null) {
      return 0;
    }
    final a = value - value.truncate();
    if (a != 0) {
      return value;
    } else {
      return value.toInt();
    }
  }

  /// Func convert từ list sang string với dấu '\' làm input api
  static String convertListToString(
    String key,
    List<String> listValue,
    List<String> conditionsBetween, {
    String conditionsLink = 'or',
  }) {
    final conditions = <String>[];

    for (var i = 0; i < listValue.length; i++) {
      conditions.add(
        '["$key", "${conditionsBetween.length > 1 ? conditionsBetween[i] : conditionsBetween.first}", "${listValue[i]}"]',
      );
    }

    return conditions.join(',"$conditionsLink",');
  }

  static String jsonConvert(
    String key,
    String value,
    String conditionsBetween,
  ) {
    return '"$key", "$conditionsBetween", "$value"';
  }
}

class FDate {
  /// dd/MM/yyy -> 21/09/1997
  static String dMy(dynamic date) {
    if (date == null) {
      return '';
    }
    if (date.runtimeType == String) {
      final tmp = DateTime.tryParse(date);
      return DateFormat('dd/MM/yyyy').format(tmp!);
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  static String hm_dMy(dynamic date) {
    if (date.runtimeType == String) {
      final tmp = DateTime.tryParse(date);
      return DateFormat('HH:mm - ${'dd/MM/yyyy'}').format(tmp!);
    } else {
      return DateFormat('HH:mm - ${'dd/MM/yyyy'}').format(date);
    }
  }

  // static String weekday_dMy(dynamic date) {
  //   String nameOfWeek(int weekday) {
  //     switch (weekday) {
  //       case 1:
  //         return lang['common_thu2'] ?? '';
  //         break;
  //       case 2:
  //         return lang['common_thu3'] ?? '';
  //         break;
  //       case 3:
  //         return lang['common_thu4'] ?? '';
  //         break;
  //       case 4:
  //         return lang['common_thu5'] ?? '';
  //         break;
  //       case 5:
  //         return lang['common_thu6'] ?? '';
  //         break;
  //       case 6:
  //         return lang['common_thu7'] ?? '';
  //         break;
  //       case 7:
  //         return lang['common_chunhat'] ?? '';
  //         break;
  //       default:
  //         return lang['common_chunhat'] ?? '';
  //     }
  //   }

  //   if (date.runtimeType == String) {
  //     final tmp = DateTime.tryParse(date);
  //     return '${nameOfWeek(tmp.weekday)}, ${DateFormat('${'dd/MM/yyyy'}').format(tmp)}';
  //   } else {
  //     return '${nameOfWeek(date?.weekday)}, ${DateFormat('${'dd/MM/yyyy'}').format(date)}';
  //   }
  // }

  static String month_Dy(dynamic date) {
    if (date.runtimeType == String) {
      final tmp = DateTime.tryParse(date);
      return DateFormat.yMMMMd().format(tmp!);
    } else {
      return DateFormat.yMMMMd().format(date);
    }
  }

  static String dMy_hm(dynamic date) {
    if (date.runtimeType == String) {
      final tmp = DateTime.tryParse(date);
      return DateFormat('${'dd/MM/yyyy'} - HH:mm').format(tmp!);
    } else {
      return DateFormat('${'dd/MM/yyyy'} - HH:mm').format(date);
    }
  }

  /// dd.MM.yyy -> 21.09.1997
  static String dot_dMy(dynamic date) {
    if (date.runtimeType == String) {
      final tmp = DateTime.tryParse(date);
      return DateFormat('dd.MM.yyyy').format(tmp!);
    } else {
      return DateFormat('dd.MM.yyyy').format(date);
    }
  }

  /// yyyy-MM-dd -> 1997-09-21
  static String yMd(dynamic date, {String format = 'dd-MM-yyyy'}) {
    if (date == null || date == '') {
      return '';
    }
    if (date.runtimeType == String) {
      final tmp = DateFormat(format).parse(date);
      return DateFormat('yyyy-MM-dd').format(tmp);
    } else {
      return DateFormat('yyyy-MM-dd').format(date);
    }
  }

  static String yMdHHmm(dynamic date, {String format = 'dd-MM-yyyy'}) {
    if (date == null || date == '') {
      return '';
    }
    if (date.runtimeType == String) {
      final tmp = DateFormat(format).parse(date);
      return DateFormat('yyyy-MM-dd HH:mm').format(tmp);
    } else {
      return DateFormat('yyyy-MM-dd HH:mm').format(date);
    }
  }

  /// MM-dd-yyy -> 09-21-1997
  static String Mdy(dynamic date) {
    if (date.runtimeType == String) {
      return DateFormat('yyyy-MM-dd').format(DateTime.tryParse(date)!);
    } else {
      return DateFormat('yyyy-MM-dd').format(date);
    }
  }

  /// dd-MM-yyy -> 23-08-1999
  static String d_M_y(dynamic date) {
    if (date.runtimeType == String) {
      return DateFormat('dd-MM-yyyy').format(DateTime.tryParse(date)!);
    } else {
      return DateFormat('dd-MM-yyyy').format(date);
    }
  }

  static String formatDate(dynamic date, String formatInput, String formatOutput) {
    if (date.runtimeType == String) {
      final temp = DateFormat(formatInput).parse(date);
      return DateFormat(formatOutput).format(temp);
    } else {
      return DateFormat(formatOutput).format(date);
    }
  }

  // HH:mm:ss
  static String hms(DateTime date) {
    final hour = date.hour;
    final minute = date.minute;
    final second = date.second;
    return '${hour < 10 ? '0$hour' : hour}:${minute < 10 ? '0$minute' : minute}:${second < 10 ? '0$second' : second}';
  }

  // HH:mm:ss
  static String hm(DateTime date) {
    final hour = date.hour;
    final minute = date.minute;
    return '${hour < 10 ? '0$hour' : hour}:${minute < 10 ? '0$minute' : minute}';
  }

  static String countdown(int seconds) {
    final h = (seconds / 3600).floor();
    final m = ((seconds - h * 3600) / 60).floor();
    final s = seconds - h * 3600 - m * 60;
    if (h == 0) {
      return '${m < 10 ? '0$m' : m}:${s < 10 ? '0$s' : s}';
    } else {
      return '${h < 10 ? '0$h' : h}:${m < 10 ? '0$m' : m}';
    }
  }

  static String dayDifference(String to, String from) {
    return '${DateTime.parse(FDate.yMd(to.replaceAll('/', '-'))).difference(DateTime.parse(FDate.yMd(from.replaceAll('/', '-')))).inDays}';
  }
}

extension WStringExtension on String {
  String wUnicodeToAscii({bool exceptLetterD = false}) {
    final content = this;

    if (content?.isNotEmpty == true) {
      final newContent = content
          .toLowerCase()
          .replaceAll(
            RegExp(r'[í|ì|ỉ|ĩ|ị]', caseSensitive: false),
            'i',
          )
          .replaceAll(
            RegExp(r'[ý|ỳ|ỷ|ỹ|ỵ]', caseSensitive: false),
            'y',
          )
          .replaceAll(
            RegExp(r'[á|à|ả|ã|ạ|â|ă|ấ|ầ|ẩ|ẫ|ậ|ắ|ằ|ẳ|ẵ|ặ]', caseSensitive: false),
            'a',
          )
          .replaceAll(
            RegExp(r'[é|è|ẻ|ẽ|ẹ|ê|ế|ề|ể|ễ|ệ]', caseSensitive: false),
            'e',
          )
          .replaceAll(
            RegExp(r'[ú|ù|ủ|ũ|ụ|ü|ư|ứ|ừ|ử|ữ|ự]', caseSensitive: false),
            'u',
          )
          .replaceAll(
            RegExp(r'[ó|ò|ỏ|õ|ọ|ô|ơ|ố|ồ|ổ|ỗ|ộ|ớ|ờ|ở|ỡ|ợ]', caseSensitive: false),
            'o',
          )
          .toLowerCase()
          .trim();
      if (exceptLetterD) {
        return newContent;
      } else {
        return newContent.replaceAll(
          RegExp(r'[đ]', caseSensitive: false),
          'd',
        );
      }
    } else {
      return '';
    }
  }
}
