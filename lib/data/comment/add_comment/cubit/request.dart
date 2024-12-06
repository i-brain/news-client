class AddCommentRequest {
  final String id;
  final String comment;
  final String username;

  AddCommentRequest({
    required this.id,
    required this.comment,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "date": DateTime.now(),
        "username": username,
      };
}
