import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:flutter/material.dart';

class CustomWarningMessageCard extends StatelessWidget {
  final String title;
  final String warningMessage;
  final IconData icon;
  final Color bgColor;

  const CustomWarningMessageCard({
    super.key,
    required this.title,
    required this.warningMessage,
    required this.icon,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 10,
      child: Container(


        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [bgColor.withOpacity(0.89),bgColor.withOpacity(0.99), bgColor.withOpacity(1)])),
        height: 200,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style:
                      kWhiteContentStyle.copyWith(fontWeight: FontWeight.w900),
                ),
                Icon(
                  icon,
                  color: Colors.white,
                  size: 70,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Text(
                warningMessage,
                softWrap: true,
                maxLines: 5,
                style: kWhiteContentStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
