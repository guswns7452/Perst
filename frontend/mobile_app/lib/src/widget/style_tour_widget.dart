import 'package:flutter/material.dart';
import 'package:perst/src/widget/google_drive_image.dart';
import '../model/fashion_search_model.dart';
import '../screen/style/fashionDetail.dart';

class StyleTourWidget extends StatefulWidget {
  final Future<List<FashionSearchModel>> fashions;

  const StyleTourWidget({Key? key, required this.fashions}) : super(key: key);

  @override
  State<StyleTourWidget> createState() => _StyleTourWidgetState();
}

class _StyleTourWidgetState extends State<StyleTourWidget> {
  @override
  void initState() {
    super.initState();
    print('아아아아앙ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ');
    print(widget.fashions);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<FashionSearchModel>>(
        future: widget.fashions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<FashionSearchModel> fashions = snapshot.data!;
            return ListView.builder(
              itemCount: (fashions.length / 2).ceil(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                int leftIndex = index * 2;
                int rightIndex = leftIndex + 1;

                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: _buildFashionItem(context, fashions[leftIndex]),
                      ),
                    ),
                    SizedBox(width: 8),
                    if (rightIndex < fashions.length)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child:
                              _buildFashionItem(context, fashions[rightIndex]),
                        ),
                      ),
                  ],
                );
              },
            );
          } else {
            return Center(
              child: Text('No data'),
            );
          }
        },
      ),
    );
  }
}

Widget _buildFashionItem(BuildContext context, FashionSearchModel fashion) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FashionDetail(fashion: fashion),
            ),
          );
        },
        child: Stack(
          children: [
            google_drive_image(
              id: fashion.musinsaFileid!,
            ),
          ],
        ),
      ),
      SizedBox(height: 6),
    ],
  );
}
