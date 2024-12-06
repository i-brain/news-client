part of 'add_comment_cubit.dart';

sealed class AddCommentState extends Equatable {
  const AddCommentState();

  @override
  List<Object> get props => [];
}

class AddCommentInitial extends AddCommentState {
  const AddCommentInitial();
}

class AddCommentLoading extends AddCommentState {
  const AddCommentLoading();
}

class AddCommentSuccess extends AddCommentState {
  @override
  List<Object> get props => [];
}

class AddCommentFailure extends AddCommentState {
  final String message;

  const AddCommentFailure(this.message);

  @override
  List<Object> get props => [message];
}
