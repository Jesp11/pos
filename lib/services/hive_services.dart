import 'package:hive/hive.dart';
import 'package:pos/models/user.dart';

class HiveServices {
  static const String userBoxName = 'userBox';

   Future<bool> registerUser(String username, String password, String role) async {
    var box = Hive.box(userBoxName);

    if (box.containsKey(username)) {
      print('El usuario ya existe');
      return false; 
    }

    User newUser = User(username: username, password: password, role: role);
    await box.put(username, newUser.toMap());
    print('Usuario registrado exitosamente');
    return true; 
  }

  Future<Map<String, dynamic>> loginUser(String username, String password) async {
  var box = Hive.box(userBoxName);

  if (box.containsKey(username)) {
    var userMap = box.get(username);
    User user = User.fromMap(Map<String, dynamic>.from(userMap));

    if (user.password == password) {
      print("Inicio de sesión exitoso");
      return {'success': true, 'role': user.role}; 
    } else {
      print('Contraseña Incorrecta');
      return {'success': false, 'role': null};
    }
  } else {
    print('Usuario no encontrado');
    return {'success': false, 'role': null};
  }
}

}
