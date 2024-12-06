import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_client/data/comment/service.dart';
import '../../../../core/constants/error_messages.dart';
import 'request.dart';

part 'add_comment_state.dart';

class AddCommentCubit extends Cubit<AddCommentState> {
  AddCommentCubit(this.service) : super(const AddCommentInitial());
  final ICommentService service;
  Future<void> addComment(AddCommentRequest request) async {
    emit(const AddCommentLoading());

    try {
      await service.addComment(request);

      emit(AddCommentSuccess());
    } on SocketException {
      emit(const AddCommentFailure(ErrorMessages.internet));
    } on FirebaseException catch (error) {
      if (error.message != null) {
        emit(AddCommentFailure(error.message!));
      } else {
        emit(const AddCommentFailure(ErrorMessages.errorOccurred));
      }
    } catch (_) {
      emit(const AddCommentFailure(ErrorMessages.errorOccurred));
    }
  }
}
