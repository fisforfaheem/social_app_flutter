// import 'dart:convert';

// class GroupPosts {
//   String Id;
//   String Description;
//   String Picture;
//   DateTime PostedDate;
//   String EPostedBy;
//   String Group_Id;
//   String name;
//   int likes;
//   String dp;
//   int PostComment;
//   GroupPosts({
//     this.Id,
//     this.Description,
//     this.Picture,
//     this.PostedDate,
//     this.EPostedBy,
//     this.Group_Id,
//     this.name,
//     this.likes,
//     this.dp,
//     this.PostComment,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'Id': Id,
//       'Description': Description,
//       'Picture': Picture,
//       'PostedDate': PostedDate.millisecondsSinceEpoch,
//       'EPostedBy': EPostedBy,
//       'Group_Id': Group_Id,
//       'name': name,
//       'likes': likes,
//       'dp': dp,
//       'PostComment': PostComment,
//     };
//   }

//   factory GroupPosts.fromMap(Map<String, dynamic> map) {
//     return GroupPosts(
//       Id: map['Id'],
//       Description: map['Description'],
//       Picture: map['Picture'],
//       PostedDate: DateTime.fromMillisecondsSinceEpoch(map['PostedDate']),
//       EPostedBy: map['EPostedBy'],
//       Group_Id: map['Group_Id'],
//       name: map['name'],
//       likes: map['likes'],
//       dp: map['dp'],
//       PostComment: map['PostComment'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory GroupPosts.fromJson(String source) =>
//       GroupPosts.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'GroupPosts(Id: $Id, Description: $Description, Picture: $Picture, PostedDate: $PostedDate, EPostedBy: $EPostedBy, Group_Id: $Group_Id, name: $name, likes: $likes, dp: $dp, PostComment: $PostComment)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is GroupPosts &&
//         other.Id == Id &&
//         other.Description == Description &&
//         other.Picture == Picture &&
//         other.PostedDate == PostedDate &&
//         other.EPostedBy == EPostedBy &&
//         other.Group_Id == Group_Id &&
//         other.name == name &&
//         other.likes == likes &&
//         other.dp == dp &&
//         other.PostComment == PostComment;
//   }

//   @override
//   int get hashCode {
//     return Id.hashCode ^
//         Description.hashCode ^
//         Picture.hashCode ^
//         PostedDate.hashCode ^
//         EPostedBy.hashCode ^
//         Group_Id.hashCode ^
//         name.hashCode ^
//         likes.hashCode ^
//         dp.hashCode ^
//         PostComment.hashCode;
//   }
// }
