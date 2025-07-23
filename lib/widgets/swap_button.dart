import 'package:flutter/material.dart';

class SwapButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SwapButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Icon(
            Icons.swap_horiz_rounded,
            color: Color(0xFFED5B2D),
            size: 28,
          ),
        ),
      ),
    );
  }
}