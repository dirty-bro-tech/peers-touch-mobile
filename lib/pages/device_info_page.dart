import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pure_touch/controller/controller.dart';

/// Example page showing device ID information
/// This demonstrates how to use the DeviceIdController in your app
class DeviceInfoPage extends StatelessWidget {
  const DeviceInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceIdController = ControllerManager.deviceIdController;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Information'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (deviceIdController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Launch Status
              _buildInfoCard(
                title: 'Installation Status',
                content: deviceIdController.isFirstLaunch.value 
                    ? 'First Launch' 
                    : 'Returning User',
                icon: deviceIdController.isFirstLaunch.value 
                    ? Icons.new_releases 
                    : Icons.verified_user,
                color: deviceIdController.isFirstLaunch.value 
                    ? Colors.green 
                    : Colors.blue,
              ),
              
              const SizedBox(height: 16),
              
              // Device ID (DID)
              _buildInfoCard(
                title: 'Device ID (DID)',
                content: deviceIdController.getCurrentDeviceId(),
                icon: Icons.fingerprint,
                color: Colors.purple,
                copyable: true,
              ),
              
              const SizedBox(height: 16),
              
              // Installation ID
              _buildInfoCard(
                title: 'Installation ID',
                content: deviceIdController.getCurrentInstallationId(),
                icon: Icons.install_mobile,
                color: Colors.orange,
                copyable: true,
              ),
              
              const SizedBox(height: 16),
              
              // Device Information
              _buildInfoCard(
                title: 'Device Information',
                content: deviceIdController.getDeviceInfoString(),
                icon: Icons.phone_android,
                color: Colors.teal,
              ),
              
              const SizedBox(height: 24),
              
              // Avatar Preview
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.account_circle, color: Colors.indigo),
                          const SizedBox(width: 8),
                          Text(
                            'Generated Avatar',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'This avatar is generated based on your device ID and will remain consistent across app sessions:',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300, width: 2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://api.dicebear.com/7.x/identicon/svg?seed=${deviceIdController.getIdenticonInput()}',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade200,
                                  child: Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.grey.shade600,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Reset Button (for testing)
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final confirmed = await _showResetConfirmation(context);
                    if (confirmed == true) {
                      await deviceIdController.resetDeviceId();
                      Get.snackbar(
                        'Reset Complete',
                        'Device ID has been reset and regenerated',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    }
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset Device ID (Testing)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
  
  Widget _buildInfoCard({
    required String title,
    required String content,
    required IconData icon,
    required Color color,
    bool copyable = false,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (copyable)
                  IconButton(
                    onPressed: () {
                      // Copy to clipboard functionality would go here
                      Get.snackbar(
                        'Copied',
                        'Content copied to clipboard',
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 2),
                      );
                    },
                    icon: const Icon(Icons.copy, size: 20),
                    tooltip: 'Copy to clipboard',
                  ),
              ],
            ),
            const SizedBox(height: 8),
            SelectableText(
              content,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<bool?> _showResetConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Device ID?'),
        content: const Text(
          'This will generate a new device ID and installation ID. '
          'This action is typically only used for testing purposes.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}