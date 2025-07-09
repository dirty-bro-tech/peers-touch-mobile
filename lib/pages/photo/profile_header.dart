import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[300],
      child: Image.network(
        'https://picsum.photos/400/200',
        fit: BoxFit.cover,
      ),
    );
  }
}
