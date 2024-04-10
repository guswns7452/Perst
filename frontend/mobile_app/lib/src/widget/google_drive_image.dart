import 'package:flutter/material.dart';

class google_drive_image extends StatelessWidget {
  final String id;

  const google_drive_image({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 500,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image:
              NetworkImage("https://drive.google.com/thumbnail?id=$id&sz=w300"),
        ),
      ),
    );
  }
}