import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_client/data/get_news/response.dart';
import '../../../core/constants/error_messages.dart';
import '../../../core/helper_functions.dart';
import '../../get_news/service.dart';

part 'get_trending_news_state.dart';

class GetTrendingNewsCubit extends Cubit<GetTrendingNewsState> {
  GetTrendingNewsCubit(this.service) : super(const GetTrendingNewsInitial());
  final INewsService service;

  Future<void> get() async {
    if (state is! GetTrendingNewsSuccess) {
      emit(const GetTrendingNewsLoading());
    }

    try {
      final response = await service.getTrendingNews();

      if (response.success) {
        emit(GetTrendingNewsSuccess(response.data));
      } else {
        emit(GetTrendingNewsFailure(response.message!));
      }
    } on DioException catch (exception) {
      if (isServerException(exception)) {
        emit(const GetTrendingNewsFailure(ErrorMessages.server));
      } else if (exception.error is SocketException) {
        emit(const GetTrendingNewsFailure(ErrorMessages.internet));
      } else {
        emit(GetTrendingNewsFailure(
            exception.message ?? ErrorMessages.errorOccurred));
      }
    } catch (_) {
      emit(const GetTrendingNewsFailure(ErrorMessages.errorOccurred));
    }
  }
}
