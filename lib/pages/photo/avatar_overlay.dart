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
                    'User Bio Ha Ha hah hasd ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      height: 1.2,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
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
        );
      },
    );
  }
}
