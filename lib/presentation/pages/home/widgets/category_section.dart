import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_client/core/extension.dart';
import 'package:news_client/data/get_category/cubit/cubit.dart';
import 'package:news_client/data/get_news/cubit/get_news_cubit.dart';

import '../../../../responsive.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xffeeeeee),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: Responsive.horizontalPadding(context),
        ),
        child: BlocBuilder<GetCategoryCubit, GetCategoryState>(
          builder: (context, state) {
            if (state is GetCategorySuccess) {
              final list = state.categories;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  list.length,
                  (index) => TextButton(
                    onPressed: () => _onTap(context, list[index].id),
                    child: Text(
                      list[index].name,
                      style: context.style.titleMedium?.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int id) {
    context.read<GetNewsCubit>().get(categoryId: id);
  }
}
