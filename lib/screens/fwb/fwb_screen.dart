import 'package:bottombar/screens/fwb/details_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../models/user_model.dart';
import '../services/services.dart';

class FwbScreen extends ConsumerWidget {
  const FwbScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<UserModel>> usersData = ref.watch(userProvider);
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Users'),
      ),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: () async {
          await Future<void>.delayed(const Duration(seconds: 1));
          ref.refresh(userProvider);
        },
        child: usersData.when(
          error: (error, stack) => Text('Error: $error'),
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (users) => ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              UserModel user = users[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        borderRadius: BorderRadius.circular(20),
                        onPressed: (context) async {
                          try {
                            await ApiServices().deleteUser(users[index].id!);
                            ref.refresh(userProvider);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Failed to delete user')),
                            );
                          }
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
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
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          try {
            await ApiServices().addUser();
            ref.refresh(userProvider);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to add user')),
            );
          }
        },
      ),
    );
  }
}
