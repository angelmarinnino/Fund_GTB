// ignore_for_file: file_names
import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  const GenericButton({
    super.key,
    required this.colorButton,
    this.imageRoute,
    required this.text,
    this.height,
    this.width,
    this.borderColor,
    this.onPressed,
    this.textStyle,
  });
  final Color colorButton;
  final Widget? imageRoute;
  final String text;
  final double? height;
  final double? width;
  final Color? borderColor;
  final TextStyle? textStyle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: colorButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          side: borderColor != null ? BorderSide(color: borderColor!) : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(text, style: textStyle, maxLines: 2),
            if (imageRoute != null) const SizedBox(width: 20),
            if (imageRoute != null) imageRoute!,
          ],
        ),
        onPressed: () {
          onPressed?.call();
        },
      ),
    );
  }
}
