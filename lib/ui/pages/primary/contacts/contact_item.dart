import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/theme/fusion_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactItem extends StatelessWidget {
  final Contact data;

  const ContactItem({@required this.data});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                  width: 64,
                  height: 64,
                  child: SvgPicture.asset(
                    "assets/images/icons/ic_man.svg",
                  ))),
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                    child: Text(
                      data.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Text(
                    data.address,
                    style: FusionTheme.subtitleTextStyle,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
