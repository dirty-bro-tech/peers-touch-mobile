import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../l10n/app_localizations.dart';
import '../../controller/friends_controller.dart';
import 'chat_search_bar.dart';
import 'chat_friend_list_item.dart';
import 'models/friend_model.dart';

class FriendsListController extends GetxController {
  final FriendsController _friendsController = FriendsController();
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  FriendsController get friendsController => _friendsController;

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void onFriendTap(FriendModel friend) {
    Get.toNamed('/chat/detail', arguments: friend);
  }

  void onFriendLongPress(FriendModel friend) {
    _showFriendBottomSheet(friend);
  }

  void _showFriendBottomSheet(FriendModel friend) {
    final l10n = AppLocalizations.of(Get.context!)!;
    
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(l10n.viewProfile),
              onTap: () {
                Get.back();
                // Navigate to profile page
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text(l10n.editRemark),
              onTap: () {
                Get.back();
                _showEditRemarkDialog(friend);
              },
            ),
            ListTile(
              leading: Icon(friend.isMuted ? Icons.notifications : Icons.notifications_off),
              title: Text(friend.isMuted ? l10n.unmute : l10n.mute),
              onTap: () {
                Get.back();
                _friendsController.toggleMute(friend.friendId);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: Text(l10n.deleteFriend, style: const TextStyle(color: Colors.red)),
              onTap: () {
                Get.back();
                _showDeleteFriendDialog(friend);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditRemarkDialog(FriendModel friend) {
    final l10n = AppLocalizations.of(Get.context!)!;
    final TextEditingController controller = TextEditingController(text: friend.remarkName);
    
    Get.dialog(
      AlertDialog(
        title: Text(l10n.editRemark),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: l10n.enterRemark,
            border: const OutlineInputBorder(),
          ),
          maxLength: 20,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              _friendsController.updateFriendRemark(friend.friendId, controller.text.trim());
              Get.back();
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  void _showDeleteFriendDialog(FriendModel friend) {
    final l10n = AppLocalizations.of(Get.context!)!;
    
    Get.dialog(
      AlertDialog(
        title: Text(l10n.deleteFriend),
        content: Text(l10n.deleteFriendConfirmation),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              _friendsController.removeFriend(friend.friendId);
              Get.back();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}

class FriendsListPage extends StatelessWidget {
  const FriendsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FriendsListController());
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.all(16),
            child: ChatSearchBar(
              controller: controller.searchController,
              hintText: l10n.searchContacts,
              onChanged: (query) {
                controller.friendsController.updateSearchQuery(query);
              },
            ),
          ),
          
          // Friends list
          Expanded(
            child: GetBuilder<FriendsController>(
              init: controller.friendsController,
              builder: (friendsController) {
                final friends = friendsController.filteredFriends;
                
                if (friends.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          friendsController.searchQuery.isEmpty 
                              ? l10n.noContactsFound
                              : 'No contacts found for "${friendsController.searchQuery}"',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  controller: controller.scrollController,
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    final friend = friends[index];
                    return FriendListItem(
                      friend: friend,
                      onTap: () => controller.onFriendTap(friend),
                      onLongPress: () => controller.onFriendLongPress(friend),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}