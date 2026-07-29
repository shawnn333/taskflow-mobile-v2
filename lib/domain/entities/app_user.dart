/// AppUser - minimal user identity, mirrors what AuthGate.jsx / the web
/// app's auth slice keeps around (uid + email only; Firebase handles the
/// rest).
class AppUser {
  final String uid;
  final String? email;

  const AppUser({required this.uid, this.email});
}
