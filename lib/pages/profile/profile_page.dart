import 'package:flutter/material.dart';
import 'package:pure_touch/components/common/floating_action_ball.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Static action options for floating action ball
  static List<FloatingActionOption> get actionOptions => [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E), // Dark background like WeChat
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // User Profile Header
              _buildUserProfileHeader(),
              const SizedBox(height: 20),
              
              // Services Section
              _buildServicesSection(),
              const SizedBox(height: 20),
              
              // Features Section
              _buildFeaturesSection(),
              const SizedBox(height: 20),
              
              // Settings Section
              _buildSettingsSection(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage('assets/images/default_avatar.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Icon(
              Icons.person,
              size: 40,
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 16),
          
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Little First',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Weixin ID: wfkbtfq',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      '+ Status',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'and other friends (4)',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // QR Code Icon
          IconButton(
            onPressed: () {
              // TODO: Show QR code
            },
            icon: const Icon(
              Icons.qr_code,
              color: Colors.white70,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.payment,
            iconColor: Colors.green,
            title: 'Pay and Services',
            onTap: () {
              // TODO: Navigate to pay and services
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.favorite,
            iconColor: Colors.red,
            title: 'Favorites',
            onTap: () {
              // TODO: Navigate to favorites
            },
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.photo_library,
            iconColor: Colors.blue,
            title: 'Moments',
            onTap: () {
              // TODO: Navigate to moments
            },
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.card_giftcard,
            iconColor: Colors.orange,
            title: 'Cards & Offers',
            onTap: () {
              // TODO: Navigate to cards and offers
            },
          ),
          _buildDivider(),
          _buildMenuItem(
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

  Widget _buildSettingsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.settings,
            iconColor: Colors.grey,
            title: 'Settings',
            onTap: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
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
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.white54,
        size: 20,
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.only(left: 64),
      height: 0.5,
      color: Colors.white12,
    );
  }
}