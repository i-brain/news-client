import 'package:flutter/material.dart';
import 'package:news_client/core/extension.dart';
import 'package:news_client/data/get_news/response.dart';
import 'package:news_client/presentation/widgets/trending_news.dart';
import '../../../../responsive.dart';
import '../../news_details/page.dart';

class HomeHeadNews extends StatelessWidget {
  const HomeHeadNews({super.key, required this.newsDetails});
  final NewsDetails newsDetails;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 40,
        horizontal: Responsive.horizontalPadding(context),
      ),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 600,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsDetailsPage(newsDetails: newsDetails),
                      ),
                    );
                  },
                  child: ColoredBox(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Image.network(
                            imageUrl,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 30, 40, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${newsDetails.title}',
                                    style: context.style.titleLarge?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const Divider(height: 40),
                                Text(
                                  '27.11.2024',
                                  style: context.style.titleSmall
                                      ?.copyWith(color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const TrendingNews()
            ],
          ),
        ),
      ),
    );
  }

  String get imageUrl =>
      'https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp';
}
