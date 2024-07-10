import 'package:flutter/material.dart';

class AppConstants {
  // App ID
  static const String bannerAds1 = 'ca-app-pub-7809188873696785/4566370624';
  static const Color primaryColor = Color(0xFF13b5f6);
  static const Color cardColor = primaryColor;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color secondaryColor = Color(0xff0a9cd5);
  static const Gradient primaryGradientColor = LinearGradient(
    colors: [secondaryColor, primaryColor],
    stops: [0, 1],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const Gradient secondaryGradientColor = LinearGradient(
    colors: [primaryColor, secondaryColor],
    stops: [0, 1],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  static const Gradient primaryBodyGradientColor = LinearGradient(
    colors: [secondaryColor, secondaryColor, primaryColor],
    stops: [0, 0.75, 1],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  static const Color tertiaryColor = Color(0xFF4CAF50);
  static const Color primaryTextColor = Color(0xFFFFFFFF);
}

class ConstantImages {
  static String emiCalculator = "assets/icons/emi-calculator.png";
  static String quickCalculator = "assets/icons/quick-calculator.png";
  static String amountToWord = "assets/icons/amount-to-word.png";
  static String compareLoans = "assets/icons/compare-loan.png";
  static String companyLogo = "assets/images/company_logo.png";
  static String appIcon = "assets/images/logo.png";
}

class CustomButtonTwo extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double borderRadius;
  final Color buttonColor;

  const CustomButtonTwo({
    super.key,
    required this.text,
    required this.onPressed,
    required this.width,
    this.height = 33.0,
    this.borderRadius = 5,
    this.buttonColor = AppConstants.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: AppConstants.primaryTextColor),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double minWidth;
  final double height;
  final double borderRadius;
  final Color buttonColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.minWidth = double.infinity,
    this.height = 50,
    this.borderRadius = 10,
    this.buttonColor = AppConstants.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: minWidth,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: AppConstants.primaryTextColor),
        ),
      ),
    );
  }
}
