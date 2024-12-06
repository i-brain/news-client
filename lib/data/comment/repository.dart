import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_client/data/comment/add_comment/cubit/request.dart';

abstract class ICommentRepository {
  Future<dynamic> addComment(AddCommentRequest reuqest);
  Stream<QuerySnapshot<Map<String, dynamic>>> commentsStream(String id);
}

class CommentRepository implements ICommentRepository {
  final newsCollection = FirebaseFirestore.instance.collection('news');

  @override
  Future<dynamic> addComment(AddCommentRequest reuqest) async {
    return newsCollection
        .doc(reuqest.id)
        .collection('comments')
        .add(reuqest.toJson());
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> commentsStream(String id) {
    return FirebaseFirestore.instance
        .collection('news')
        .doc(id)
        .collection('comments')
        .snapshots();
  }
}
