import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_client/data/auth/login/cubit/login_cubit.dart';
import 'package:news_client/data/comment/add_comment/cubit/add_comment_cubit.dart';
import 'package:news_client/data/get_category/cubit/cubit.dart';
import 'package:news_client/data/get_news/cubit/get_news_cubit.dart';
import 'package:news_client/data/get_trending/cubit/get_trending_news_cubit.dart';

import 'core/services/di.dart';
import 'presentation/pages/home/page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetNewsCubit(getIt())..get()),
        BlocProvider(create: (context) => GetCategoryCubit(getIt())..get()),
        BlocProvider(create: (context) => GetTrendingNewsCubit(getIt())),
        BlocProvider(create: (context) => LoginCubit(getIt())),
        BlocProvider(create: (context) => AddCommentCubit(getIt())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mews',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xfff7f7f7),
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          canvasColor: const Color(0xFF2A2D3E),
        ),
        home: const HomePage(),
      ),
    );
  }
}
