import 'dart:math';

String generateCustomID() {
  DateTime now = DateTime.now();

  // Formatea la fecha y hora en un número
  String formattedDate = "${now.year}${_padZero(now.month)}${_padZero(now.day)}"
                          "${_padZero(now.hour)}${_padZero(now.minute)}"
                          "${_padZero(now.second)}";

  // Genera un número aleatorio entre 1000 y 9999
  Random random = Random();
  int randomNum = 1000 + random.nextInt(9000); // Número entre 1000 y 9999

  // Combina la fecha y el número aleatorio
  String combinedString = "$formattedDate$randomNum";

  // Retorna el ID numérico
  return combinedString; // Retorna la cadena combinada
}

String _padZero(int value) {
  return value.toString().padLeft(2, '0'); // Agrega un cero a la izquierda si es necesario
}
