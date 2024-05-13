import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perst/src/screen/auth/intro.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.nanumGothic().fontFamily,),
      debugShowCheckedModeBanner: false,
      home: Intro(),
    );
  }
}
