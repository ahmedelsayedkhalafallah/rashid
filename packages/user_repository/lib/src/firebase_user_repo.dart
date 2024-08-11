import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:user_repository/src/models/my_user.dart';
import 'package:user_repository/user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');
  static MyUser myUserObject = MyUser.empty;
  String? verifyId;

  FirebaseUserRepo({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  @override
  // TODO: implement user
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email, password: password);

      myUser = myUser.copyWith(
        userId: user.user?.uid,
      );

      return myUser;
    } catch (e) {
      log(e.toString());

      return MyUser.empty;
      // rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      await userCollection
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<MyUser> getCurrentUser() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final uid = user?.uid;
      myUserObject = await userCollection.doc(uid).get().then(
          (value) {
             if(value.exists){
              return MyUser.fromEntity(UserEntity.fromDocument(value.data()));
             }else{
              return MyUser.empty;
             }
             }
          );

      return myUserObject;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> getUser(String field, String input) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(field, isEqualTo: input)
          .get();
      final doc = querySnapshot.docs.firstOrNull;

      if (doc != null) {
        return MyUser.fromEntity(UserEntity.fromDocument(doc.data()));
      } else {
        return MyUser.empty;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> sendPhoneNumberVerification(String phoneNumber) async {
    // FirebaseAuth auth = FirebaseAuth.instance;

    // await FirebaseAuth.instance.verifyPhoneNumber(
    //   phoneNumber: '+2$phoneNumber',
    //   verificationCompleted: (PhoneAuthCredential credential) async {
    //     await auth.signInWithCredential(credential);
    //   },
    //   verificationFailed: (FirebaseAuthException e) {
    //     if (e.code == 'invalid-phone-number') {
    //       print('The provided phone number is not valid.');
    //     }
    //   },
    //   codeSent: (String verificationId, int? resendToken) {
    //     print(verificationId);
    //     verifyId = verificationId;
    //   },
    //   codeAutoRetrievalTimeout: (String verificationId) {},

    // );
    return verifyId.toString();
  }

  @override
  Future<void> verifyPhoneNumber(String smsCode, String phoneNumber) async {
    // FirebaseAuth auth = FirebaseAuth.instance;
    // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verifyId!, smsCode: smsCode);

    // await auth.signInWithCredential(credential).then((result)async{
    //   if(result.user != null){

    //     MyUser myUser = await getCurrentUser();
    //     myUser = myUser.copyWith(isVerified: true);
    //     setUserData(myUser);
    //   }
    // }).catchError((e){
    //   print(e);
    // });
    MyUser myUser = await getCurrentUser();
    myUser = myUser.copyWith(isVerified: true);
    setUserData(myUser);
  }

  @override
  Future<String> uploadPicture(String imageFilePath, String userId) async {
    try {
      File imageFile = File(imageFilePath);
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('$userId/ProfilePicture/${userId}_lead');
      await firebaseStorageRef.putFile(imageFile);
      String url = await firebaseStorageRef.getDownloadURL();
      await userCollection.doc(userId).update({'profilePictureUrl': url});
      return url;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> uploadExternalPicture(File imageFile, String userId) async {
    try {
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('$userId/ProfilePicture/${userId}_lead');
      await firebaseStorageRef.putFile(imageFile);
      String url = await firebaseStorageRef.getDownloadURL();
      await userCollection.doc(userId).update({'profilePictureUrl': url});
      return url;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> sendResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<File> downloadExternalPicture(String pictureLink) async {
    final response = await http.get(Uri.parse(pictureLink));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(join(documentDirectory.path, 'userPhoto.png'));

    file.writeAsBytesSync(response.bodyBytes);
    return file;
  }

  @override
  Future<MyUser> signInWithGoogle() async {
    final auth = FirebaseAuth.instance;
    final googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        await auth.signInWithCredential(authCredential);
        MyUser checkUser = await getCurrentUser();
        if(checkUser.email == ""){
          setExternalUserData();
        }
      
       
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      rethrow;
    }
    return await getCurrentUser();
  }
  
  Future<void> setExternalUserData() async{
      final User? user = FirebaseAuth.instance.currentUser;
        final uid = user?.uid;
        MyUser myUser = MyUser(
            email: FirebaseAuth.instance.currentUser!.email.toString(),
            userId: uid.toString(),
            name: FirebaseAuth.instance.currentUser!.displayName.toString(),
            phoneNumber:
                FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
            profilePictureUrl: "",
            isVerified: false,
            mySyllables: {});
        setUserData(myUser);

        uploadExternalPicture(
            await downloadExternalPicture(
                FirebaseAuth.instance.currentUser!.photoURL.toString()),
            uid.toString());
  }
}
