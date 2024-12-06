import 'package:cloud_firestore/cloud_firestore.dart';

List<CommentDetails> getCommentsFromSnapshot(
        List<QueryDocumentSnapshot> docs) =>
    List<CommentDetails>.from(
        docs.map((x) => CommentDetails.fromJson(x.data())));

class CommentDetails {
  final String? id;
  final String? username;
  final String? comment;
  final dynamic date;

  CommentDetails({
    this.id,
    this.username,
    this.comment,
    this.date,
  });

  factory CommentDetails.fromJson(json) => CommentDetails(
        id: json["id"],
        username: json["username"],
        comment: json["comment"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "comment": comment,
        "date": date,
      };
}
