import 'package:daily/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final bool isLoading;
  const MyButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    Key? key,
    this.width,
    this.height = 54,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    const double borderRadius = 15;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 15),
          primary: primaryColor,
          onPrimary: Theme.of(context).backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitFadingCircle(
                    color: Theme.of(context).cardColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Loading...",
                    style: AppTextStyle.normal.copyWith(
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ],
              )
            : Text(
                text,
                style: AppTextStyle.title.copyWith(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
