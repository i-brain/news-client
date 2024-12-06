import 'package:flutter/material.dart';
import 'package:news_client/data/get_news/response.dart';
import '../home/widgets/footer.dart';
import '../home/widgets/gridview_news.dart';
import '../home/widgets/header.dart';
import 'widgets/main_news.dart';

class NewsDetailsPage extends StatelessWidget {
  const NewsDetailsPage({super.key, required this.newsDetails});
  final NewsDetails newsDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const MainHeader(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                NewsDetailsMainNews(newsDetails: newsDetails),
                const GridviewNews(),
                const MainFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
