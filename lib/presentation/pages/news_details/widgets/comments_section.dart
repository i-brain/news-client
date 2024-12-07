import 'package:flutter/material.dart';
import 'package:news_client/core/constants/colors.dart';
import 'package:news_client/core/extension.dart';
import 'package:news_client/data/get_news/response.dart';
import 'package:news_client/presentation/pages/news_details/widgets/add_comment_field.dart';
import '../../../../core/services/di.dart';
import '../../../../data/comment/get_comment/response.dart';
import '../../../../data/comment/repository.dart';

class CommentsSection extends StatelessWidget {
  const CommentsSection({super.key, required this.newsDetails});
  final NewsDetails newsDetails;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Comments',
            style: context.style.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        AddCommentField(newsDetails: newsDetails),
        const SizedBox(height: 10),
        StreamBuilder(
          stream:
              getIt<ICommentRepository>().commentsStream(newsDetails.title!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final list = getCommentsFromSnapshot(snapshot.data!.docs);
              return Column(
                children: List.generate(
                  list.length,
                  (index) => CommentItem(index: index, comment: list[index]),
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
  const CommentItem({super.key, required this.index, required this.comment});
  final CommentDetails comment;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${comment.username}',
                style: context.style.titleMedium?.copyWith(
                  color: index.isEven ? primaryColor : const Color(0xffb8191f),
                ),
              ),
              Text(
                ' - 10.08.2023',
                style: context.style.bodyMedium?.copyWith(color: Colors.black),
              )
            ],
          ),
          Text(
            '${comment.comment}',
            style: context.style.bodyMedium,
          )
        ],
      ),
    );
  }

  String get imageUrl =>
      'https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp';
}
