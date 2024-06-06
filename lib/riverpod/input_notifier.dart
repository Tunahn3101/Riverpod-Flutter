import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/addtrips/models/input_text_model.dart';

final inputProvider =
    StateNotifierProvider<InputNotifier, List<InputTextModel>>(
        (ref) => InputNotifier());
final selectedImageProvider = StateProvider<File?>((ref) => null);
final searchQueryProvider = StateProvider<String>((ref) => '');

class InputNotifier extends StateNotifier<List<InputTextModel>> {
  InputNotifier() : super([]);

  void addInput(InputTextModel input) {
    state = [...state, input];
  }

  void removeInput(int index) {
    state = [...state]..removeAt(index);
  }
}
