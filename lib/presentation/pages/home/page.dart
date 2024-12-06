import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_client/data/get_news/cubit/get_news_cubit.dart';
import 'package:news_client/presentation/pages/home/widgets/footer.dart';
import 'package:news_client/presentation/pages/home/widgets/gridview_news.dart';
import 'package:news_client/presentation/pages/home/widgets/header.dart';

import 'widgets/category_section.dart';
import 'widgets/head_news.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetNewsCubit, GetNewsState>(
        builder: (context, state) {
          if (state is GetNewsSuccess) {
            return Column(
              children: [
                const MainHeader(),
                const CategorySection(),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      HomeHeadNews(newsDetails: state.headNews),
                      const GridviewNews(),
                      const MainFooter(),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
