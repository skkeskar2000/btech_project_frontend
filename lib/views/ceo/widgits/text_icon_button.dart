import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final Icon icon;
  final String title;
  final bool isSelected;

  const IconTextButton(
      {Key? key,
      required this.icon,
      required this.title,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                      Colors.purpleAccent.shade400,
                      Colors.blueAccent.shade700,
                      Colors.blueAccent.shade400,
                    ])
              : LinearGradient(colors: [Colors.black, Colors.black])),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: kContentStyle.copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}
