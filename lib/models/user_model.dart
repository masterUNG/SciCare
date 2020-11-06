class UserModel {
  String id;
  String name;
  String username;
  String password;

  UserModel({this.id, this.name, this.username, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    username = json['Username'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Username'] = this.username;
    data['Password'] = this.password;
    return data;
  }
}

class UserModel2 {
  String id;
  String idUser;
  String detail;
  String phone;
  String urlPicItem;

  UserModel2({this.id, this.idUser, this.detail, this.phone, this.urlPicItem});

  UserModel2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['idUser'];
    detail = json['Detail'];
    phone = json['Phone'];
    urlPicItem = json['UrlPicItem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idUser'] = this.idUser;
    data['Detail'] = this.detail;
    data['Phone'] = this.phone;
    data['UrlPicItem'] = this.urlPicItem;
    return data;
  }
}

class UserModel3 {
  String id;
  String name;
  String username;
  String password;
  String bio;
  String urlProfile;

  UserModel3(
      {this.id,
        this.name,
        this.username,
        this.password,
        this.bio,
        this.urlProfile});

  UserModel3.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    username = json['Username'];
    password = json['Password'];
    bio = json['Bio'];
    urlProfile = json['UrlProfile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Username'] = this.username;
    data['Password'] = this.password;
    data['Bio'] = this.bio;
    data['UrlProfile'] = this.urlProfile;
    return data;
  }
}
