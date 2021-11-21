import '../constants/enums.dart';

class User {
  String? id;
  String? fname;
  String? lname;
  String? email;
  String? profileUrl;
  Currencies? currency;

  User(
      {this.fname,
      this.lname,
      this.email,
      this.currency,
      this.id,
      this.profileUrl});

  User copyWith({
    String? id,
    String? fname,
    String? lname,
    String? email,
    String? profileUrl,
    Currencies? currency,
  }) {
    return User(
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      currency: currency ?? this.currency,
      id: id ?? this.id,
      profileUrl: profileUrl ?? this.profileUrl,
    );
  }

  static User fromJson(Map<String, dynamic> json) => User(
      fname: json['fname'],
      lname: json['lname'],
      email: json['email'],
      profileUrl: json['profileUrl'],
      id: json['id'],
      currency: Currencies.values[json['currency']]);
  Map<String, dynamic> toJson() => {
        'id': id,
        'fname': fname,
        'lname': lname,
        'email': email,
        'profileUrl': profileUrl,
        'currency': Currencies.values.indexOf(currency!),
      };
}
