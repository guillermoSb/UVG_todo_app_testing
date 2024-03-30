// ignore_for_file: public_member_api_docs, sort_constructors_first
typedef UserID = String;

/// Representation for the user entity.
class AppUser {
  AppUser({required this.id, required this.email});
  final UserID id;
  final String email;

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.id == id && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;

  @override
  String toString() => 'AppUser(id: $id, email: $email)';
}
