import 'package:flutter/material.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildMenuItem(
            context,
            icon: Icons.favorite,
            iconColor: Colors.red,
            title: 'Favorites',
            onTap: () {
              // TODO: Navigate to favorites
            },
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            icon: Icons.photo_library,
            iconColor: Colors.blue,
            title: 'Moments',
            onTap: () {
              // TODO: Navigate to moments
            },
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            icon: Icons.card_giftcard,
            iconColor: Colors.orange,
            title: 'Cards & Offers',
            onTap: () {
              // TODO: Navigate to cards and offers
            },
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            icon: Icons.emoji_emotions,
            iconColor: Colors.yellow,
            title: 'Sticker Gallery',
            onTap: () {
              // TODO: Navigate to sticker gallery
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: iconColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 16,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.54),
        size: 20,
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 64),
      height: 0.5,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.12),
    );
  }
}