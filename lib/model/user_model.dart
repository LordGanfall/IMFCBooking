class UserModel {
  String? uid;
  String? email;
  String? fullname;
  String? username;
  String? password;

  UserModel({this.uid, this.email, this.fullname, this.username, this.password});

  //receiving data froms erver
  factory UserModel.fromMap(map)
  {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullname: map['fullname'],
      username: map['username'],
      password: map['password'],
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'email': email,
      'fullname': fullname,
      'username': username,
      'password': password,
    };
  }

}