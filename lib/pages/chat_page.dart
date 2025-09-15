import 'package:flutter/material.dart';
import 'package:pure_touch/components/common/floating_action_ball.dart';
import 'package:pure_touch/common/logger/logger.dart';

class ChatPage extends StatelessWidget {
  static final List<FloatingActionOption> actionOptions = [
    FloatingActionOption(
      icon: Icons.group_add,
      tooltip: 'New Group',
      onPressed: () => appLogger.info('New Group pressed'),
    ),
    FloatingActionOption(
      icon: Icons.person_add,
      tooltip: 'Add Contact',
      onPressed: () => appLogger.info('Add Contact pressed'),
    ),
  ];

  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(); // Your actual chat page implementation
  }
}