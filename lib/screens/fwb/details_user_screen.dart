import 'package:bottombar/models/user_model.dart';
import 'package:flutter/material.dart';

class DetailsUserScreen extends StatelessWidget {
  const DetailsUserScreen({
    super.key,
    required this.e,
  });

  final UserModel e;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(e.avatar!),
            ),
            Text(e.id!),
            Text(e.firstName!),
            Text(e.lastName!),
            Text(e.email!),
          ],
        ),
      ),
    );
  }
}
