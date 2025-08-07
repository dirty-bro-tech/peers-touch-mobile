import 'package:flutter/material.dart';

class FloatingActionOption {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const FloatingActionOption({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });
}

class FloatingActionBall extends StatefulWidget {
  final List<FloatingActionOption> options;

  const FloatingActionBall({
    super.key,
    required this.options,
  });

  @override
  State<FloatingActionBall> createState() => _FloatingActionBallState();
}

class _FloatingActionBallState extends State<FloatingActionBall> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Widget _buildOptionButton(FloatingActionOption option, double offset) {
    return Positioned(
      bottom: offset * 50, // Reduced spacing for closer options
      right: 6, // Move slightly to the left
      child: AnimatedOpacity(
        opacity: _isExpanded ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
          heroTag: null,
          mini: true,
          onPressed: () {
            option.onPressed();
            _toggleExpansion();
          },
          tooltip: option.tooltip,
          child: Icon(option.icon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56, // Adequate width to show buttons fully
      height: 56 + (widget.options.length * 50), // Adequate height with closer spacing
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 0,
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 300),
              turns: _isExpanded ? 0.125 : 0,
              child: FloatingActionButton(
                mini: true, // Make main button smaller
                onPressed: _toggleExpansion,
                child: Icon(_isExpanded ? Icons.close : Icons.add),
              ),
            ),
          ),

          ...widget.options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            return _buildOptionButton(option, (index + 1).toDouble());
          }),
        ],
      ),
    );
  }
}
