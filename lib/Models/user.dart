class User {
  int? id;
  String? first_name,
      last_name,
      gender,
      username,
      email,
      password,
      password_confirmation,
      token;

  User({
    this.id,
    this.first_name,
    this.last_name,
    this.gender,
    this.username,
    this.email,
    this.password,
    this.password_confirmation,
    this.token,
  });

  //function to convert json data to user model
  factory User.fromjson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      first_name: json['user']['first_name'],
      last_name: json['user']['last_name'],
      gender: json['user']['gender'],
      username: json['user']['username'],
      email: json['user']['email'],
      password: json['user']['password'],
      password_confirmation: json['user']['password_confirmation'],
      token: json['user']['token'],
    );
  }
}
