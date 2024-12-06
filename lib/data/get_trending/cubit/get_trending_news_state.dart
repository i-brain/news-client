part of 'get_trending_news_cubit.dart';

sealed class GetTrendingNewsState extends Equatable {
  const GetTrendingNewsState();

  @override
  List<Object> get props => [];
}

class GetTrendingNewsInitial extends GetTrendingNewsState {
  const GetTrendingNewsInitial();
}

class GetTrendingNewsLoading extends GetTrendingNewsState {
  const GetTrendingNewsLoading();
}

class GetTrendingNewsSuccess extends GetTrendingNewsState {
  final List<NewsDetails> list;

  const GetTrendingNewsSuccess(this.list);
  @override
  List<Object> get props => [list];
}

class GetTrendingNewsFailure extends GetTrendingNewsState {
  final String message;

  const GetTrendingNewsFailure(this.message);

  @override
  List<Object> get props => [message];
}
