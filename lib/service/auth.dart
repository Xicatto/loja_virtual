import 'package:firebase_auth/firebase_auth.dart';
import 'package:lojavirtual/model/User.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Criando um objeto de User baseado no FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // Stream de mudança de estado do usuário
  Stream<User> get user {
    return _auth.onAuthStateChanged
    .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // Logar com email & senha
  Future signInWithEmailAndPassword(String email, String password) async {

    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);    
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Registrar com email & senha
  Future registerWithEmailAndPassword(String email, String password) async {

    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);    
    } catch(e) {
      rethrow;
    }
  }

  // Deslogar
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}