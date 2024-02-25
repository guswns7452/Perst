import 'package:flutter/material.dart';

class google_drive_image extends StatelessWidget {
  const google_drive_image({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: (300),
        height: (300),
        decoration: new BoxDecoration(
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage(
                    "https://drive.google.com/thumbnail?id=1ePHl_Wt1bZKgiCQ6PF8OAwABq7fTmLV5&sz=w300"))));
  }
}
