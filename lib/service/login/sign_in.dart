import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_utils_app/screens/login_success_screen.dart';
import 'package:student_utils_app/service/googleapi/apis.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/calendar',
    'https://www.googleapis.com/auth/calendar.events',
  ],
);

Future<bool> signInWithGoogle({bool silently = false}) async {
  GoogleSignInAccount googleSignInAccount;
  FirebaseUser user;

  expiry = DateTime.now().add(Duration(minutes: 55)).toUtc();

  if (silently) {
    googleSignInAccount = await googleSignIn.signInSilently();
  } else {
    googleSignInAccount = await googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    user = await _auth.signInWithCredential(credential);

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoUrl != null);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', user.displayName);
    prefs.setString('email', user.email);
    prefs.setString('imageUrl', user.photoUrl);
  }
  await getApiAccess();

  return user != null;
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('name');
  prefs.remove('email');
  prefs.remove('imageUrl');

  dateEvents.clear();
}
