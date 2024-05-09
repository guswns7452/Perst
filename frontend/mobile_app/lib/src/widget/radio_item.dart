import 'package:flutter/material.dart';

class StyleRadioItem extends StatelessWidget {
  final StyleRadioModel _item;
  StyleRadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
            height: 40.0,
            child: Center(
              child: Text(_item.buttonText,
                  style: TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      fontSize: 18.0)),
            ),
            decoration: BoxDecoration(
                color: _item.isSelected
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : Colors.transparent,
                border: Border.all(
                    width: 1.0,
                    color: _item.isSelected
                        ? Color.fromARGB(255, 0, 0, 0)
                        : Colors.grey),
                borderRadius: BorderRadius.circular(10)),
          ),
        ],
      ),
    );
  }
}

class ColorRadioItem extends StatelessWidget {
  final ColorRadioModel _item;
  ColorRadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Row(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(_item.Red, _item.Green, _item.Blue, 1),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 0.3, color: Colors.black),
                ),
              ),
              Icon(Icons.favorite_border,
                  color: _item.isSelected
                      ? _item.Red == 255 &&
                              _item.Green == 255 &&
                              _item.Blue == 255
                          ? Colors.black
                          : Colors.white
                      : Colors.transparent),
            ],
          )
        ],
      ),
    );
  }
}

class StyleRadioModel {
  bool isSelected;
  final String buttonText;
  final String keyward;

  StyleRadioModel(this.isSelected, this.buttonText, this.keyward);
}

class ColorRadioModel {
  bool isSelected;
  final int Red;
  final int Green;
  final int Blue;
  final String ColorName;

  ColorRadioModel(
      this.isSelected, this.Red, this.Green, this.Blue, this.ColorName);
}
