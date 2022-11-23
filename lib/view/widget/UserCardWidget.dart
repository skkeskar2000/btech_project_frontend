import 'package:flutter/material.dart';

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({Key? key, required this.employeeName}) : super(key: key);
  final String employeeName;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 1,
              color: Colors.black12,
              offset: Offset(0, 3),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.black12,
            child: ClipRRect(
              child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
            ),
          ),
          Text(
            employeeName,
          ),
          const Divider(
            color: Colors.black,
          ),
          const Text('Flutter Developer'),
          Container(
            alignment: Alignment.center,
            // color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.location_on_outlined,
                  size: 15,
                ),
                Text('Pune')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
