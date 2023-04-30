import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ProfileWidgit extends StatelessWidget {
  final String name;
  const ProfileWidgit({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            child: Icon(
              CupertinoIcons.profile_circled,
              size: 40,
            ),
          ),
          Text(
            name,
            style: kHeadingTextStyle.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}