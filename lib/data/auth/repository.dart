import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_client/data/auth/login/request.dart';
import 'package:news_client/data/auth/register/request.dart';

abstract class IAuthRepository {
  Future<void> register(RegisterRequest reuqest);
  Future<void> logout();
  Future<void> login(LoginRequest request);
}

class AuthRepository implements IAuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  final collectionRef = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> register(RegisterRequest reuqest) async {
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: reuqest.email,
      password: reuqest.password,
    );
    User? user = credential.user;
    if (user != null) {
      user.updateDisplayName(reuqest.username);
      return collectionRef.doc(user.uid).set({
        'username': reuqest.username,
        'email': reuqest.email,
        'password': reuqest.password,
        'id': user.uid,
        'role': 'user',
      });
    }
    throw Exception('Firebase server error. Try again later');
  }

  @override
  Future<void> login(LoginRequest request) async {
    await auth.signInWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
  }

  @override
  Future<void> logout() {
    return auth.signOut();
  }
}
