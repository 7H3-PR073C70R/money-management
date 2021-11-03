import 'package:money_management/constants/enums.dart';

class User {
  String? id;
  String? fname;
  String? lname;
  String? email;
  String? profileUrl;
  Currencies? currency;

  User(
      {this.id,
      this.fname,
      this.lname,
      this.email,
      this.currency,
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
      id: id ?? this.id,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      currency: currency ?? this.currency,
      profileUrl: profileUrl ?? this.profileUrl,
    );
  }

  static User fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      fname: json['fname'],
      lname: json['lname'],
      email: json['email'],
      profileUrl: json['profileUrl'],
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
