import 'dart:math';

String generateCustomID() {
  DateTime now = DateTime.now();

  String formattedDate = "${now.year}${_padZero(now.month)}${_padZero(now.day)}"
                          "${_padZero(now.hour)}${_padZero(now.minute)}"
                          "${_padZero(now.second)}";

  Random random = Random();
  int randomNum = 1000 + random.nextInt(9000); 

  String combinedString = "$formattedDate$randomNum";

  return combinedString; 
}

String _padZero(int value) {
  return value.toString().padLeft(2, '0');
}
