import 'package:flutter/material.dart';
import 'package:perst/src/widget/google_drive_image.dart';
import '../model/fashion_search_model.dart';
import '../screen/style/fashionDetail.dart';

class StyleTourWidget extends StatefulWidget {
  final List<FashionSearchModel> fashions;

  const StyleTourWidget({Key? key, required this.fashions}) : super(key: key);

  @override
  State<StyleTourWidget> createState() => _StyleTourWidgetState();
}

class _StyleTourWidgetState extends State<StyleTourWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<FashionSearchModel> fashions = widget.fashions;
    return Expanded(
      child: ListView.builder(
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
                    child: _buildFashionItem(context, fashions[rightIndex]),
                  ),
                ),
            ],
          );
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
              builder: (context) => FashionDetail(
                fashion: fashion,
                personalColorChecked: true,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Container(
              height: 200,
              child: google_drive_image(
                id: fashion.musinsaFileid!,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 6),
    ],
  );
}
