import 'package:hive/hive.dart';
import 'package:pos/models/user.dart';

class HiveServices {
  
  static const String userBoxName = 'userBox';
  
  Future <void> registerUser(User user) async {
    var box = Hive.box(userBoxName);
    await box.put(user.username, user.toMap());
    print("Usuario Registrado con Exito");
  }

  Future <bool> loginUser(String username, String password) async {
    var box = Hive.box(userBoxName);

    if(box.containsKey(username)){
      var userMap = box.get(username);
      User user = User.fromMap(Map<String, dynamic>.from(userMap));

      if (user.password == password) {
        print("Inicio de sesion exitoso");
        return true;
      }
      else {
        print('Contraseña Incorrecta');
        return false;
      }

    } else {
      print('Usuario no encontrado');
      return false;
    }
  }
}