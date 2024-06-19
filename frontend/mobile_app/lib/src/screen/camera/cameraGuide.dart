import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CameraGuide extends StatelessWidget {
  const CameraGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(231, 231, 231, 0.91),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    width: double.infinity,
                    child: Text(
                      '   사진 가이드',
                      style: GoogleFonts.gowunDodum(
                        textStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 104, 104, 104),
                        ),
                      ),
                      textAlign: TextAlign.start,
                    )),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  width: double.infinity,
                  child: Text(
                    '     양 발끝을 선에 맞춰서 정자세로 서주세요.',
                    style: GoogleFonts.gowunDodum(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        color: Color.fromARGB(255, 104, 104, 104),
                      ),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                  width: double.infinity,
                  height: 610,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset('assets/man2.png'),
                  alignment: Alignment.bottomCenter,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
