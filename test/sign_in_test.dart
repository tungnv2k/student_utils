import 'package:student_utils_app/service/login/sign_in.dart';
import 'package:test/test.dart';

void main() {
  group('Sign in', () async {
    test('Sign in normally', () async {
      var result = await signInWithGoogle();

      expect(result, true);
    });
    test('Sign in silent', () async {
      var result = await signInWithGoogle(silently: true);

      expect(result, true);
    });
    test('Sign in failed', () async {
      var result = await signInWithGoogle();
      // User doesn't want to log in
      expect(result, false);
    });
    test('Sign in failed', () async {
      var result = await signInWithGoogle(silently: true);
      // Doesn't exist previous user
      expect(result, false);
    });
  });
}