import 'package:flutter/material.dart';

class AvatarOverlay extends StatelessWidget {
  const AvatarOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    // Remove the outer Positioned widget here
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'User Name',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text(
                    _processBioText(
                      'User Bio Ha Ha hah hasd hello hello hello hello hello, hi hi hi hi hi hi hi hi hi ',
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      height: 1,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    softWrap: true, // Allow text wrapping
                    overflow: TextOverflow.visible, // Allow text overflow
                    maxLines: 2, // Set maxLines to allow multiple lines
                    // Removed maxLines to enable multi-line display
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Transform.translate(
              offset: const Offset(0, 3), // Lower by 3 units vertically
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(width: 14),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: NetworkImage('https://picsum.photos/100'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Helper to add line break after 8th word
  String _processBioText(String bio) {
    final words = bio.split(' ');
    if (words.length > 8) {
      return '${words.sublist(0, 8).join(' ')}\n${words.sublist(8).join(' ')}';
    }
    return bio;
  }
}
