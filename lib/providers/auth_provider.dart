import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';

class DemoUser {
  final String uid;
  final String? displayName;
  final String? email;
  final String? photoURL;

  DemoUser({required this.uid, this.displayName, this.email, this.photoURL});
}

final firestoreServiceProvider = Provider<FirestoreService>((ref) => FirestoreService());

final authStateProvider = StreamProvider<DemoUser?>((ref) {
  // Demo mode: always return a logged-in demo user
  return Stream.value(DemoUser(
    uid: 'demo-uid-123',
    displayName: 'Heritage Explorer',
    email: 'explorer@heritageos.com',
    photoURL: null,
  ));
});

final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  return UserProfile(
    uid: 'demo-uid-123',
    name: 'Heritage Explorer',
    email: 'explorer@heritageos.com',
    createdAt: DateTime.now(),
    savedPlaceIds: [],
  );
});

class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  AuthNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 500));
    state = const AsyncValue.data(null);
  }

  Future<void> signUp(String email, String password, String name) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 500));
    state = const AsyncValue.data(null);
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 500));
    state = const AsyncValue.data(null);
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 300));
    state = const AsyncValue.data(null);
  }

  Future<void> resetPassword(String email) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 300));
    state = const AsyncValue.data(null);
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<void>>(
  (ref) => AuthNotifier(ref),
);
