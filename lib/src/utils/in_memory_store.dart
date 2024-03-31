// coverage:ignore-file
import 'package:rxdart/rxdart.dart';

/// In-memory store to hold a single value [T].
class InMemoryStore<T> {
  InMemoryStore(T initial)
      : _store = BehaviorSubject<T>.seeded(
            initial); // Seed the store with an initial value.
  final BehaviorSubject<T> _store;

  Stream<T> get stream => _store.stream;

  T get value => _store.value;

  /// Set the value of the store.
  set value(T newValue) {
    _store.add(newValue);
  }

  /// Close the store.
  void close() {
    _store.close();
  }
}
