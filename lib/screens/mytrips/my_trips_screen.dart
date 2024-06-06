import 'dart:io';

import 'package:bottombar/riverpod/input_notifier.dart';
import 'package:bottombar/screens/mytrips/ui_input_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/app_size.dart';

class MyTripsScreen extends ConsumerWidget {
  MyTripsScreen({
    super.key,
  });
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputs = ref.watch(inputProvider);
    final String searchQuery = ref.watch(searchQueryProvider.state).state;

    final filteredInputs = inputs.where((input) {
      final searchLowercase = searchQuery.toLowerCase();
      return input.name.toLowerCase().contains(searchLowercase) ||
          input.description.toLowerCase().contains(searchLowercase) ||
          input.location.toLowerCase().contains(searchLowercase);
    }).toList();
    return Scaffold(
      body: Padding(
        padding: AppSize.uiPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            UiInputSearch(
              controller: searchController,
              onSearch: (value) {
                ref.read(searchQueryProvider.state).state = value;
              },
            ),
            const SizedBox(height: 30),
            Expanded(
                child: ListView.builder(
              itemCount: filteredInputs.length,
              itemBuilder: (context, index) {
                final input = filteredInputs[index];
                return InkWell(
                  onTap: () {},
                  child: Card(
                    child: Column(
                      children: [
                        // Kiểm tra và hiển thị ảnh nếu tồn tại path
                        if (input.imagePath != null)
                          Image.file(
                            File(input.imagePath!),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ) // Không cần dùng Set, trực tiếp nhúng vào List
                        else
                          const Icon(Icons.image,
                              size: 200), // Cách sửa lỗi tại đây
                        ListTile(
                          title: Text(input.name),
                          subtitle: Text(
                              "${input.description} - ${input.location} - ${input.gender}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => ref
                                .read(inputProvider.notifier)
                                .removeInput(index),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
