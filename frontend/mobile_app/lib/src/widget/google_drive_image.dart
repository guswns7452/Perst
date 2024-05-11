import 'package:flutter/material.dart';

class google_drive_image extends StatelessWidget {
  final String id;

  const google_drive_image({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 171,
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                "https://drive.google.com/thumbnail?id=$id&sz=w300"),
          ),
          borderRadius: BorderRadius.circular(7)),
    );
  }
}
