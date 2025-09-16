import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:peers_touch_mobile/components/common/floating_action_ball.dart';
import 'package:peers_touch_mobile/pages/chat/chat_list_page.dart';
import 'package:peers_touch_mobile/controller/controller.dart';
import 'package:peers_touch_mobile/utils/app_localizations_helper.dart';
import 'package:peers_touch_mobile/common/logger/logger.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  static final List<FloatingActionOption> actionOptions = [
    FloatingActionOption(
      icon: Icons.group_add,
      tooltip: AppLocalizationsHelper.getLocalizedString((l10n) => l10n.newGroup, 'New Group'),
      onPressed: () => appLogger.info('New Group pressed'),
    ),
    FloatingActionOption(
      icon: Icons.person_add,
      tooltip: AppLocalizationsHelper.getLocalizedString((l10n) => l10n.addContact, 'Add Contact'),
      onPressed: () => appLogger.info('Add Contact pressed'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return const ChatListPage();
  }
}