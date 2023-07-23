import 'dart:convert';

class TitlePost {
  int Id;
  String Description;
  String Sposted_By;
  String Eposted_By;
  String Type;
  String Post_Pic;
  int Title_Id;
  DateTime Date;
  String Wall_Post_Type;
  String Session_Post;
  TitlePost({
    required this.Id,
    required this.Description,
    required this.Sposted_By,
    required this.Eposted_By,
    required this.Type,
    required this.Post_Pic,
    required this.Title_Id,
    required this.Date,
    required this.Wall_Post_Type,
    required this.Session_Post,
  });

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'Description': Description,
      'Sposted_By': Sposted_By,
      'Eposted_By': Eposted_By,
      'Type': Type,
      'Post_Pic': Post_Pic,
      'Title_Id': Title_Id,
      'Date': Date.toString(),
      'Wall_Post_Type': Wall_Post_Type,
      'Session_Post': Session_Post,
    };
  }

  factory TitlePost.fromMap(Map<String, dynamic> map) {
    return TitlePost(
      Id: map['Id'],
      Description: map['Description'],
      Sposted_By: map['Sposted_By'],
      Eposted_By: map['Eposted_By'],
      Type: map['Type'],
      Post_Pic: map['Post_Pic'],
      Title_Id: map['Title_Id'],
      Date: DateTime.fromMillisecondsSinceEpoch(map['Date']),
      Wall_Post_Type: map['Wall_Post_Type'],
      Session_Post: map['Session_Post'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TitlePost.fromJson(String source) =>
      TitlePost.fromMap(json.decode(source));
}

class TitleAdd {
  int id;
  String title1;
  TitleAdd({
    required this.id,
    required this.title1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title1': title1,
    };
  }

  factory TitleAdd.fromMap(Map<String, dynamic> map) {
    return TitleAdd(
      id: map['id'],
      title1: map['title1'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TitleAdd.fromJson(String source) =>
      TitleAdd.fromMap(json.decode(source));
}
