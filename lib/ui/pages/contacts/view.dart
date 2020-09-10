import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/utils/flasher.dart';
import 'package:fusion_wallet/utils/haptic.dart';
import 'package:fusion_wallet/utils/io_tools.dart';

import '../../../inject.dart';
import '../../../localizations.dart';



class ContactItem extends StatelessWidget {
  final Contact data;

  const ContactItem({@required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Theme.of(context).colorScheme.surface,
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: GestureDetector(
        onTap: () {
          FlashHelper.successBar(context,
              message:
              AppLocalizations.of(context).addressCopied);
          injector.get<HapticUtil>().selection();
          IOTools.setSecureClipboardItem(this.data.address);
        },
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
                          child: AutoSizeText(
                            data.address,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
