import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/constants/error_messages.dart';
import '../../service.dart';
import '../request.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.service) : super(const RegisterInitial());
  final IAuthService service;

  Future<void> register(RegisterRequest request) async {
    emit(const RegisterLoading());

    try {
      await service.register(request);

      emit(RegisterSuccess());
    } on SocketException {
      emit(const RegisterFailure(ErrorMessages.internet));
    } on FirebaseAuthException catch (error) {
      if (error.message != null) {
        emit(RegisterFailure(error.message!));
      } else {
        emit(const RegisterFailure(ErrorMessages.errorOccurred));
      }
    } catch (_) {
      emit(const RegisterFailure(ErrorMessages.errorOccurred));
    }
  }
}
