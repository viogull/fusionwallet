import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactItem extends StatelessWidget {
  final Contact data;

  const ContactItem({@required this.data});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 3,
      color: Theme.of(context).colorScheme.surface,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 13),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                      width: 48,
                      height: 48,
                      child: SvgPicture.asset(
                        "assets/images/icons/ic_man.svg",
                      ))),
            ),
            Flexible(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 4),
                        child: Text(
                          data.name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 4),
                        child: Text(
                          data.address,
                          textAlign: TextAlign.start,
                          style: FusionTheme.subtitleTextStyle,
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
