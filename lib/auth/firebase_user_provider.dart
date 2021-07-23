import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ToDoFirebaseUser {
  ToDoFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

ToDoFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ToDoFirebaseUser> toDoFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<ToDoFirebaseUser>((user) => currentUser = ToDoFirebaseUser(user));
