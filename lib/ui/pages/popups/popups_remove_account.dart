import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';

class PopupsRemoveAccount extends StatelessWidget {
//  final String title;
//  final String subtitle;
//  final String asset;

  // ExchangePage(this.title, this.asset, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 5,),
              Flexible(
                flex: 2,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: Text(
                    'Remove Account',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: 100,
                    height: 100,
                    child: SizedBox.expand(
                      child: SvgPicture.asset(
                        ('assets/images/icons/ic_delete.svg'),
                        semanticsLabel: 'Popup Icon',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: Text(
                    'You are about to remove an account. Are you sure you want to proceed with choice?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    height: 50,
                    width: MediaQuery.of(context).size.width ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: FusionButton(

                            AppLocalizations.of(context).labelOk(),
                                () {
                              Navigator.pop(context);
                            },
                          ),
                        ),

                        Flexible(
                          flex: 1,
                          child: FusionButton(
                            AppLocalizations.of(context).labelOk(),
                                () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    )

                ),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      ),

    );
  }
}
