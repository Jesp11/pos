import 'package:hive/hive.dart';
import 'package:pos/models/user.dart';

class HiveServices {
  static const String userBoxName = 'userBox';

   Future<bool> registerUser(String username, String password, String role) async {
    var box = Hive.box(userBoxName);

    if (box.containsKey(username)) {
      return false; 
    }

    User newUser = User(username: username, password: password, role: role);
    await box.put(username, newUser.toMap());
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
      return {'success': false, 'role': null};
    }
  } else {
    return {'success': false, 'role': null};
  }
}

}
