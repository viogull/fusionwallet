import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/ui/components/custom/scaffold.dart';

import '../../../inject.dart';
import '../../../localizations.dart';
import '../../widgets.dart';

class ApplyPushDeeplink extends StatelessWidget {
  final String url;

  ApplyPushDeeplink({this.url});
//TODO
  @override
  Widget build(BuildContext context) {
    return FusionScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: Text(
                    AppLocalizations.of(context).applyPushTitle(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Container(
                    width: 156,
                    height: 156,
                    child: SvgPicture.asset(
                      ('assets/images/icons/ic_delete.svg'),
                      semanticsLabel: 'Popup Icon',
                      color: Theme.of(context).colorScheme.primary,
                      fit: BoxFit.fill,
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
                    AppLocalizations.of(context).applyPushBody("", "",
                        StateContainer.of(context).selectedAccount.address),
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
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: FusionButton(
                              text: AppLocalizations.of(context).labelOk(),
                              onPressed: () async {
                                final applyAttempt = await injector
                                    .get<MinterRest>()
                                    .applyPush(
                                        url,
                                        StateContainer.of(context)
                                            .selectedAccount
                                            .address);

                                if (applyAttempt == true) {
                                  FlashHelper.successBar(context,
                                      message: AppLocalizations.of(context)
                                          .pushFundsSuccesfullyApplied());
                                } else {
                                  FlashHelper.errorBar(context,
                                      message: AppLocalizations.of(context)
                                          .pushFundsNotApplied());
                                }
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  Navigator.of(context).pop();
                                });
                              }),
                        ),
                        Flexible(
                          flex: 1,
                          child: FusionButton(
                            text: AppLocalizations.of(context).labelCancel(),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
