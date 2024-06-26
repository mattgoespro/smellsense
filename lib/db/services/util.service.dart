import 'dart:async';

import 'package:uuid/uuid.dart';

String generateUuid() => const Uuid().v4().toString();

class ListCollector<T> implements StreamConsumer<List<T>> {
  final List<T> _collectedData = [];

  @override
  Future addStream(Stream<List<T>> stream) {
    return stream.listen((data) {
      _collectedData.addAll(data);
    }).asFuture();
  }

  @override
  Future close() async {
    if (_collectedData.isEmpty) {
      throw Exception('Data stream ended with no data.');
    }
  }

  List<T> get collectedData => _collectedData;
}
