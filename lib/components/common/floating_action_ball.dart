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
    return Padding(
      padding: EdgeInsets.only(bottom: offset * 60),
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
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        AnimatedRotation(
          duration: const Duration(milliseconds: 300),
          turns: _isExpanded ? 0.125 : 0,
          child: FloatingActionButton(
            onPressed: _toggleExpansion,
            child: Icon(_isExpanded ? Icons.close : Icons.add),
          ),
        ),

        ...widget.options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          return _buildOptionButton(option, (index + 1).toDouble());
        }),
      ],
    );
  }
}
