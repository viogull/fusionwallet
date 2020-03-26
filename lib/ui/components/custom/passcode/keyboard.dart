import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef KeyboardTapCallback = void Function(String text);

class KeyboardUIConfig {
  final double digitSize;
  final double digitBorderWidth ;
  final TextStyle digitTextStyle;
  final TextStyle deleteButtonTextStyle;
  final Color primaryColor;
  final Color digitFillColor;
  final EdgeInsetsGeometry keyboardRowMargin;
  final EdgeInsetsGeometry deleteButtonMargin;

  KeyboardUIConfig({
    this.digitSize = 45,
    this.digitBorderWidth = 0.1,
    this.keyboardRowMargin = const EdgeInsets.only(top: 25),
    this.primaryColor = Colors.tealAccent,
    this.digitFillColor = Colors.black12,
    this.digitTextStyle = const TextStyle(fontSize: 22, color: Colors.white),
    this.deleteButtonMargin =
        const EdgeInsets.only(right: 0, left: 20, top: 45),
    this.deleteButtonTextStyle =
        const TextStyle(fontSize: 16, color: Colors.white),
  });
}

class Keyboard extends StatelessWidget {
  final KeyboardUIConfig keyboardUIConfig;
  final GestureTapCallback onDeleteCancelTap;
  final KeyboardTapCallback onKeyboardTap;
  final bool shouldShowCancel;
  final String cancelLocalizedText;
  final String deleteLocalizedText;

  Keyboard(
      {Key key,
      @required this.keyboardUIConfig,
      @required this.onDeleteCancelTap,
      @required this.onKeyboardTap,
      this.shouldShowCancel = true,
      @required this.cancelLocalizedText,
      @required this.deleteLocalizedText})
      : super(key: key);

  @override
  Widget build(BuildContext context) => _buildKeyboard();

  Widget _buildKeyboard() {
    return Column(
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(height: 70),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildKeyboardDigit('1'),
            _buildKeyboardDigit('2'),
            _buildKeyboardDigit('3'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildKeyboardDigit('4'),
            _buildKeyboardDigit('5'),
            _buildKeyboardDigit('6'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildKeyboardDigit('7'),
            _buildKeyboardDigit('8'),
            _buildKeyboardDigit('9'),
          ],
        ),
        Stack(
          children: <Widget>[
            Center(child: _buildKeyboardDigit('0')),
            Align(alignment: Alignment.topRight, child: _buildDeleteButton())
          ],
        ),
      ],
    );
  }

  Widget _buildKeyboardDigit(String text) {
    return Container(

      margin: keyboardUIConfig.keyboardRowMargin,
      width: keyboardUIConfig.digitSize,
      height: keyboardUIConfig.digitSize,
      child: ClipOval(
        child: Material(
          color: keyboardUIConfig.digitFillColor,
          child: InkWell(
            highlightColor: keyboardUIConfig.digitFillColor,
            splashColor: keyboardUIConfig.digitFillColor.withOpacity(1.0),
            onTap: () {
              onKeyboardTap(text);
            },
            child: Center(
              child: Text(
                text,
                style: keyboardUIConfig.digitTextStyle,
              ),
            ),
          ),
        ),
      ),

      decoration: BoxDecoration(
            boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 6), // changes position of shadow
          ),
        ],
       // shape: BoxShape.rectangle,
        color: keyboardUIConfig.digitFillColor,
        borderRadius: BorderRadius.circular(5.0),
//        border: Border.all(
//            color: keyboardUIConfig.digitFillColor,
//            width: keyboardUIConfig.digitBorderWidth,
//        ),
      ),
    );
  }


  Widget _buildDeleteButton() {
    return Container(
      margin: keyboardUIConfig.deleteButtonMargin,
          child: GestureDetector(
            onTap: onDeleteCancelTap,
            child: SvgPicture.asset('assets/images/icons/ic_deletearrow.svg'),
            ),
    );
  }
}
