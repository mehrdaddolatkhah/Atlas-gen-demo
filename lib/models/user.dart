class User {
  int id;
  String name;
  String family;
  String username;
  String password;
  String birthday;
  String mobile;
  String nationalId;

  User(this.id, this.name, this.family, this.username, this.password,
      this.birthday, this.mobile, this.nationalId);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'family': family,
      'username': username,
      'password': password,
      'birthday': birthday,
      'mobile': mobile,
      'nationalId': nationalId,
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    family = map['family'];
    username = map['username'];
    password = map['password'];
    birthday = map['birthday'];
    mobile = map['mobile'];
    nationalId = map['nationalId'];
  }
}
