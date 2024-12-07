import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_client/data/get_news/response.dart';
import 'package:news_client/presentation/widgets/custom_text_field.dart';
import '../../../../data/comment/add_comment/cubit/add_comment_cubit.dart';
import '../../../../data/comment/add_comment/cubit/request.dart';

class AddCommentField extends StatefulWidget {
  const AddCommentField({
    super.key,
    required this.newsDetails,
  });
  final NewsDetails newsDetails;
  @override
  State<AddCommentField> createState() => _AddCommentFieldState();
}

class _AddCommentFieldState extends State<AddCommentField> {
  late final TextEditingController _commentController;
  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: _commentController,
                  hint: 'Add comment',
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final username =
                        FirebaseAuth.instance.currentUser!.displayName!;
                    final request = AddCommentRequest(
                      id: widget.newsDetails.title!,
                      comment: _commentController.text,
                      username: username,
                    );
                    context.read<AddCommentCubit>().addComment(request);
                    _commentController.clear();
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
