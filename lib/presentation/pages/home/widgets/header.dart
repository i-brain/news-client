import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_client/core/extension.dart';
import 'package:news_client/data/get_news/cubit/get_news_cubit.dart';
import '../../../../responsive.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xffb8191f),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: Responsive.horizontalPadding(context),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              context.read<GetNewsCubit>().get();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Mews",
                    style: context.style.titleLarge
                        ?.copyWith(fontSize: 32, color: Colors.white)),
                const SizedBox(width: 10),
                const Icon(Icons.flutter_dash, size: 32)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
