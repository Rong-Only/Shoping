class User {
  int? id;
  String? first, last, gender, username, email, pass, confirm;

  User({
    this.id,
    this.first,
    this.last,
    this.gender,
    this.username,
    this.email,
    this.pass,
    this.confirm,
  });

  //function to convert json data to user model
  factory User.fromjson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      first: json['user']['first'],
      last: json['user']['last'],
      gender: json['user']['gender'],
      username: json['user']['username'],
      email: json['user']['email'],
      pass: json['user']['pass'],
      confirm: json['user']['confirm'],
    );
  }
}
