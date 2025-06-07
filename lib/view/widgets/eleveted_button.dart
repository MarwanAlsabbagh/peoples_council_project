import 'package:flutter/material.dart';
import '../../utils/globall_color.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const ButtonWidget({
    Key? key,
    required this.text,
     this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: GlobalColors.mainColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18
          ),
        ),
      ),
    );
  }
}
