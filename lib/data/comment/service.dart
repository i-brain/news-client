import 'add_comment/cubit/request.dart';
import 'repository.dart';

abstract class ICommentService {
  Future<dynamic> addComment(AddCommentRequest request);
}

class CommentService implements ICommentService {
  CommentService(this.repository);
  final ICommentRepository repository;

  @override
  Future<dynamic> addComment(AddCommentRequest request) {
    return repository.addComment(request);
  }
}
