import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_client/core/extension.dart';
import 'package:news_client/data/get_news/response.dart';
import 'package:news_client/data/get_trending/cubit/get_trending_news_cubit.dart';
import '../../responsive.dart';
import '../pages/news_details/page.dart';

class TrendingNews extends StatefulWidget {
  const TrendingNews({super.key});

  @override
  State<TrendingNews> createState() => _TrendingNewsState();
}

class _TrendingNewsState extends State<TrendingNews> {
  @override
  void initState() {
    super.initState();
    context.read<GetTrendingNewsCubit>().get();
  }

  @override
  Widget build(BuildContext context) {
    if (!Responsive.isMobile(context)) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: ColoredBox(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Text(
                    'Trending news',
                    style: context.style.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffb8191f),
                    ),
                  ),
                ),
                const Divider(height: 20),
                Expanded(
                  child:
                      BlocBuilder<GetTrendingNewsCubit, GetTrendingNewsState>(
                    builder: (context, state) {
                      if (state is GetTrendingNewsSuccess) {
                        final list = state.list;
                        return ListView.builder(
                          itemCount: list.length,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemBuilder: (context, index) =>
                              _TrendingNewsItem(index, list[index]),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

class _TrendingNewsItem extends StatelessWidget {
  const _TrendingNewsItem(this.index, this.newsDetails);
  final int index;
  final NewsDetails newsDetails;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailsPage(newsDetails: newsDetails),
          ),
        );
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${index + 1}.',
                style: context.style.bodyLarge?.copyWith(color: Colors.black),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '${newsDetails.title}',
                  style: context.style.titleMedium?.copyWith(
                    color: Colors.black,
                  ),
                  maxLines: 2,
                ),
              )
            ],
          ),
          const Divider(height: 30, color: Colors.grey)
        ],
      ),
    );
  }
}
