import 'package:flutter/material.dart';
import 'package:news_client/core/extension.dart';
import 'package:news_client/data/get_news/response.dart';
import 'package:news_client/presentation/pages/news_details/widgets/comments_section.dart';
import '../../../../responsive.dart';

class NewsDetailsMainNews extends StatefulWidget {
  const NewsDetailsMainNews({super.key, required this.newsDetails});
  final NewsDetails newsDetails;

  @override
  State<NewsDetailsMainNews> createState() => _NewsDetailsMainNewsState();
}

class _NewsDetailsMainNewsState extends State<NewsDetailsMainNews> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 40,
        horizontal: Responsive.horizontalPadding(context),
      ),
      sliver: SliverToBoxAdapter(
        child: ColoredBox(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 400,
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  '${widget.newsDetails.title}',
                  style: context.style.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Divider(height: 40),
                Text(
                  '${widget.newsDetails.details}',
                  style: context.style.bodyMedium,
                ),
                const SizedBox(height: 20),
                CommentsSection(newsDetails: widget.newsDetails),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String get imageUrl =>
      'https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp';
}
