import 'package:flutter/material.dart';
import 'package:news_client/core/extension.dart';
import 'package:news_client/data/get_news/response.dart';
import 'package:news_client/presentation/pages/news_details/widgets/add_comment_field.dart';
import '../../../../core/services/di.dart';
import '../../../../data/comment/get_comment/response.dart';
import '../../../../data/comment/repository.dart';
import '../../../widgets/profile_photo.dart';

class CommentsSection extends StatelessWidget {
  const CommentsSection({super.key, required this.newsDetails});
  final NewsDetails newsDetails;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Comments', style: context.style.titleMedium),
        const SizedBox(height: 20),
        AddCommentField(newsDetails: newsDetails),
        const SizedBox(height: 20),
        StreamBuilder(
          stream:
              getIt<ICommentRepository>().commentsStream(newsDetails.title!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final list = getCommentsFromSnapshot(snapshot.data!.docs);
              return Column(
                children: List.generate(
                  list.length,
                  (index) => CommentItem(comment: list[index]),
                ),
              );
            }
            return const SizedBox();
          },
        )
      ],
    );
  }
}

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.comment});
  final CommentDetails comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ProfilePhoto(imageUrl: imageUrl),
            const SizedBox(width: 4),
            Text('${comment.username}', style: context.style.titleSmall)
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            '${comment.comment}',
            style: context.style.bodyMedium,
          ),
        )
      ],
    );
  }

  String get imageUrl =>
      'https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp';
}
