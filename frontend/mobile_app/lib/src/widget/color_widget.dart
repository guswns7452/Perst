import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perst/src/controller/fashion_search_controller.dart';
import 'package:perst/src/model/fashion_search_model.dart';
import 'package:perst/src/widget/google_drive_image.dart';

final GetStorage _storage = GetStorage();

class ThreeKeywordFashion extends StatefulWidget {
  final String styleKeyword;

  const ThreeKeywordFashion({required this.styleKeyword, Key? key})
      : super(key: key);

  @override
  State<ThreeKeywordFashion> createState() => _ThreeKeywordFashionState();
}

class _ThreeKeywordFashionState extends State<ThreeKeywordFashion> {
  final fashionSearchController = Get.put(FashionSearchController());
  late Future<List<FashionSearchModel>> fashions;

  @override
  void initState() {
    super.initState();
    String gender = _storage.read("gender");
    if (gender == "woman") {
      fashions = fashionSearchController.searchWoman(widget.styleKeyword);
    } else if (gender == "man") {
      fashions = fashionSearchController.searchMan(widget.styleKeyword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FashionSearchModel>>(
      future: fashions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<FashionSearchModel>? fashions = snapshot.data;
          if (fashions == null || fashions.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: fashions.length > 3 ? 3 : fashions.length,
              itemBuilder: (context, index) {
                final fashion = fashions[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: 210,
                      child: google_drive_image(id: fashion.musinsaFileid!)),
                );
              },
            );
          }
        }
      },
    );
  }
}
