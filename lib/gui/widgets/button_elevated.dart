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
          mainAxisAlignment: imageRoute != null
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: <Widget>[
            if (imageRoute != null) imageRoute!,
            if (imageRoute != null) const SizedBox(width: 20),
            Text(text, style: textStyle, maxLines: 2),
          ],
        ),
        onPressed: () {
          onPressed?.call();
        },
      ),
    );
  }
}
