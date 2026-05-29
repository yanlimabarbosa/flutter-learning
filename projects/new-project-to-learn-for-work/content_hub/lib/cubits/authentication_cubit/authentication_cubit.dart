import 'dart:async';

import 'package:content_hub/cubits/authentication_cubit/authentication_state.dart';
import 'package:content_hub/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthenticationInitial()) {
    _authSubscription = _authRepository.authStateChanges.listen(
      _onAuthStateChanged,
    );
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<User?> _authSubscription;

  void _onAuthStateChanged(User? user) {
    if (user == null) {
      emit(AuthenticationUnauthenticated());
      return;
    }

    emit(AuthenticationAuthenticated(user: user));
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthenticationLoading());

    try {
      await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      emit(
        AuthenticationFailure(message: error.message ?? 'Failed to sign in.'),
      );
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    emit(AuthenticationLoading());

    try {
      await _authRepository.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      emit(
        AuthenticationFailure(message: error.message ?? "Failed to sign up."),
      );
    }
  }

  Future<void> signOut() {
    return _authRepository.signOut();
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
