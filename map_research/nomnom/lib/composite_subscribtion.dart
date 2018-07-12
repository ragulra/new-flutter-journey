import 'dart:async';

class CompositeSubscription {
  Set<StreamSubscription> _subscriptons = new Set();

  void cancel() {
    for (var n in this._subscriptons) {
      n.cancel();
    }
    this._subscriptons = new Set();
  }

  void add(StreamSubscription subcription) {
    this._subscriptons.add(subcription);
  }

  void addAll(Iterable<StreamSubscription> subs) {
    _subscriptons.addAll(subs);
  }

  bool remove(StreamSubscription subscription) {
    return this._subscriptons.remove(subscription);
  }

  bool contains(StreamSubscription subscription) {
    return this._subscriptons.contains(subscription);
  }

  List<StreamSubscription> toList() {
    return this._subscriptons.toList();
  }
}