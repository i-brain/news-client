import 'package:flutter/material.dart';
import 'package:news_client/core/extension.dart';
import 'package:news_client/data/get_news/cubit/get_news_cubit.dart';
import 'package:news_client/data/get_news/response.dart';
import 'package:news_client/presentation/pages/news_details/page.dart';
import '../../../../responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridviewNews extends StatefulWidget {
  const GridviewNews({super.key});

  @override
  State<GridviewNews> createState() => _GridviewNewsState();
}

class _GridviewNewsState extends State<GridviewNews> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 40,
        horizontal: Responsive.horizontalPadding(context),
      ),
      sliver: BlocBuilder<GetNewsCubit, GetNewsState>(
        builder: (context, state) {
          if (state is GetNewsSuccess) {
            final newsList = state.news;
            return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _OtherNewsCard(newsList[index]);
                },
                childCount: newsList.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.0,
              ),
            );
          }
          if (state is GetNewsFailure) {
            return SliverToBoxAdapter(
              child: Text(state.message, style: context.style.bodyLarge),
            );
          }
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  int get crossAxisCount => Responsive.isDesktop(context)
      ? 3
      : Responsive.isTablet(context)
          ? 2
          : 1;
}

class _OtherNewsCard extends StatelessWidget {
  const _OtherNewsCard(this.newsDetails);
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
      child: Card(
        color: Colors.white,
        elevation: 4.0,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                // newsDetails.imageUrl ?? '',
                'https://media.istockphoto.com/id/1369150014/vector/breaking-news-with-world-map-background-vector.jpg?s=612x612&w=0&k=20&c=9pR2-nDBhb7cOvvZU_VdgkMmPJXrBQ4rB1AkTXxRIKM=',
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text('${newsDetails.category?.name}'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${newsDetails.title}',
                            style: context.style.titleMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Colors.grey,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '27.11.2024',
                              style: context.style.titleSmall
                                  ?.copyWith(color: Colors.grey, fontSize: 10),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
