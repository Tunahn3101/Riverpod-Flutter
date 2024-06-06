import 'package:bottombar/screens/fwb/details_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user_model.dart';
import '../services/services.dart';

class FwbScreen extends ConsumerWidget {
  const FwbScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<UserModel>> usersData = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Users'),
      ),
      body: usersData.when(
        error: (error, stack) => Text('Error: $error'),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (users) => ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            UserModel user = users[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsUserScreen(e: user),
                      ));
                },
                child: Card(
                  child: ListTile(
                    title: Text(user.firstName!),
                    subtitle: Text(user.lastName!),
                    leading: user.avatar != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(user.avatar!),
                          )
                        : const CircleAvatar(child: Icon(Icons.person)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
