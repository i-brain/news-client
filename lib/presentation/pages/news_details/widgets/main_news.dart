import 'package:flutter/material.dart';
import 'package:news_client/core/extension.dart';
import 'package:news_client/data/get_news/response.dart';
import 'package:news_client/presentation/widgets/profile_photo.dart';

import '../../../../responsive.dart';

class NewsDetailsMainNews extends StatelessWidget {
  const NewsDetailsMainNews({super.key, required this.newsDetails});
  final NewsDetails newsDetails;
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
                  '${newsDetails.title}',
                  style: context.style.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Divider(height: 40),
                Text(
                  '${newsDetails.details}',
                  style: context.style.bodyMedium,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                        color: Colors.black),
                    Text('142 likes', style: context.style.titleSmall)
                  ],
                ),
                Text('Comments', style: context.style.titleMedium),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ProfilePhoto(imageUrl: imageUrl),
                    const SizedBox(width: 4),
                    Text('Akif Islamov', style: context.style.titleSmall)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    'I do not think this is true!',
                    style: context.style.bodyMedium,
                  ),
                )
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
