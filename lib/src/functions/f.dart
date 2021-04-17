import 'package:components_venver/src/settings/variable.dart';
import 'package:flutter/cupertino.dart';

class F {
  F._();

  // ! Global
  static const String dayWord = "dia";
  static const String hourWord = "hora";
  static const String minuteWord = "minuto";
  static const String andWord = "e";

  static const int bottomLimitInMinutes = 5;
  static const int topLimitInMinutes = 5;
  static const String fromWord = "de";
  static const String untilWord = "até";

  static bool isWeb(BuildContext context) {
    return isWebApplication
      ? MediaQuery.of(context).size.width >= webStartsWithWidth
      : false;
  }

  /// Returns the quantity of days, hours and minutes based on [d]
  /// 
  /// If [d] is < 1 minute, it returns ""
  /// 
  /// [returnOnlyOneField] to return only the most important field
  /// 
  /// [abbreviated] to return: "1d, 2h and 1m"
  /// 
  /// [simplified] to return: "1d02h01m" or "2h01"
  static String dHM( 
    Duration d, 
    {bool returnOnlyOneField = false,
    bool abbreviated = false,
    bool hideSeparator = false,
    bool simplified = false,
  }) {
    String _phrase(int number, String unityType) {
      String result = "$number";
      if(abbreviated) result += "${unityType[0]}";
      else if(number > 1) result += " ${unityType}s";
      else result += " $unityType";
      return result;
    }
    
    if(simplified) {
      abbreviated = true;
      hideSeparator = true;
    }
    
    List<String> fields = [];
    String result = ""; // Standard value = ""
    if(d.inDays > 0) {
      fields.add(_phrase(d.inDays, dayWord));
      d = Duration(
        minutes: d.inMinutes - Duration(days: d.inDays).inMinutes,
      );
    }
    if(d.inHours > 0) {
      fields.add(_phrase(d.inHours, hourWord));
      d = Duration(
        minutes: d.inMinutes - Duration(hours: d.inHours).inMinutes,
      );
    }
    if(d.inMinutes > 0) {
      fields.add(_phrase(d.inMinutes, minuteWord));
    }
    
    if(fields.isEmpty) return result;
    if(returnOnlyOneField) return fields[0];
    result = "";
    
    for(int i = 0; i < fields.length; i++) {
      result += fields[i];
      if(!hideSeparator) {
        if(i + 2 == fields.length) result += " $andWord ";
        else if(i + 2 < fields.length) result += ", ";
      } else if (i + 1 < fields.length){
        String numbers = fields[i + 1].replaceAll(
          RegExp(r'[^0-9]'),
          "",
        );
        bool addZero = numbers.length < 2;
        if(i + 1 != fields.length && addZero) {
          result += "0";
        }
      }
    }
    if(
      simplified &&
      fields.length > 1 &&
      result[result.length - 1] == minuteWord[0] &&
      result.contains(hourWord[0]) &&
      !result.contains(dayWord[0])
    ) {
      result = result.substring(0, result.length - 1);
    }
    
    return result;
  }
  /*
  print("Example:");
  List<Duration> list = [
    Duration(days: 1, hours: 2, minutes: 1),
    Duration(days: 1, minutes: 1),
    Duration(days: 1, hours: 2),
    Duration(hours: 2, minutes: 3),
    Duration(hours: 2),
    Duration(days: 1),
    Duration.zero,
  ];
  list.forEach((element) {
    print("$element");
    print("(normal):             ${dHM(element)}");
    print("(returnOnlyOneField): ${dHM(element, returnOnlyOneField: true)}");
    print("(abbreviated):        ${dHM(element, abbreviated: true)}");
    print("(simplified):         ${dHM(element, simplified: true)}\n");
  });
  */

  /// Return the bottom and top limit based on a Duration [d]
  /// 
  /// Example: "from 55m until 1h05"
  static String bottomAndTopLimit(Duration d) {
    Duration dBottomLimit = Duration(
      minutes: d.inMinutes - bottomLimitInMinutes,
    );
    Duration dTopLimit = Duration(
      minutes: d.inMinutes + topLimitInMinutes,
    );
    return "$fromWord ${
      dHM(dBottomLimit, simplified: true)
    } $untilWord ${
      dHM(dTopLimit, simplified: true)
    }";
  }
  /*
  print("Example:");
  List<Duration> list = [
    Duration(minutes: 60),
    Duration(minutes: 119),
    Duration(minutes: 120),
    Duration(minutes: 240),
  ];
  list.forEach((element) {
    print("$element: ${b(element)}");
  });
  */

  // It returns a list of initialized FocusNode instance
  List<FocusNode> initialilzeFocusNodeList(int quantity) {
    List<FocusNode> returned = [];
    for(int i = 0; i < quantity; i++) {
      returned.add(FocusNode());
    }
    return returned;
  }
}