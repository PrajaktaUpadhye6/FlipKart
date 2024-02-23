




import 'package:firebase_auth/firebase_auth.dart';


// import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthServices{

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> registerWithEmailandPassword(String email, String password) async{
    try{
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
      
    }catch(e){
      print("Error occured");
    }
    return null;
  }

  Future<User?> signInWithEmailandPassword(String email, String password) async{
    try{
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
      
    }catch(e){
      print("Error occured");
    }
    return null;
  }


}