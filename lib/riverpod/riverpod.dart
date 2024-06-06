import 'package:flutter_riverpod/flutter_riverpod.dart';

// Tạo một provider cho giá trị số đếm
final counterProvider = StateProvider<int>((ref) {
  return 0;
});
// tạo một provider sử dụng dữ liệu bất đồng bộ sử dụng Future
final dataProvider = FutureProvider<String>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Hello, Riverpod!';
});

// tạo một provier sử dụng dữ liệu bất đồng bộ sử dụng Stream
final streamProvider = StreamProvider<int>((ref) {
  return Stream.periodic(
    const Duration(seconds: 1),
    (count) => count,
  ).take(20);
});

// final riverpodHardLevel = ChangeNotifierProvider<RiverpodMode>((ref) {
//   return Riverpod
// });