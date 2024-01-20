import 'dart:developer';

class InMemoryCache {
  // singleton
  static final InMemoryCache _instance = InMemoryCache._internal();

  factory InMemoryCache() {
    return _instance;
  }

  InMemoryCache._internal();

  // storage variables
  String? phoneNumber;

  // copyWith method
  void copyWith({
    String? phoneNumber,
  }) {
    this.phoneNumber = phoneNumber ?? this.phoneNumber;
  }
}
