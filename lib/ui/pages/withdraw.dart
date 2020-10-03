





import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fusion_wallet/core/models/personal_invoices_response.dart';
import 'package:fusion_wallet/inject.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/scaffold.dart';
import 'package:fusion_wallet/ui/pages/withdraw/create.dart';

import 'withdraw/invoice.dart';

class WithdrawUi extends StatelessWidget {


  static const navId = "/withdrawal/all";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FusionScaffold(
      title: AppLocalizations.of(context).myInvoicesTitle(),
      fab: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 16,
        onPressed: () {
          showPlatformModalSheet(context: context, builder: (context) => CreateInvoiceUi());
        },
      ),
      child: FutureBuilder(
        future: injector.get<MinterRest>().fetchInvoices(id: '5f6a1a75c91bfa7b0fdfc3d4'),
        builder: (context, snapshot)  {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return buildLoadingUi(context);
          } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData)  {
            final invoices = (snapshot.data as PersonalInvoicesResponse).invoices;
            debugPrint('Local ${invoices.length}');
            return AnimationLimiter(
              child: (invoices.isEmpty)
                  ? showEmptyView(context)
                  : ListView.builder(
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                      child: FadeInAnimation(
                          duration: Duration(milliseconds: 500),
                          child: InvoiceItem(
                            data: invoices[index],
                          )),
                      position: index);
                },
                physics: ClampingScrollPhysics(),
                itemCount: invoices.length,
              ),
            );
          } else {
            return buildLoadingUi(context);
          }
        },
      ),
    );
  }



  Widget buildLoadingUi(BuildContext context) => Center(
    child: PlatformCircularProgressIndicator(),
  );

  Widget showEmptyView(BuildContext context) =>
      Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FlutterIcons.file_invoice_dollar_faw5s, color: Theme.of(context).colorScheme.error, size: 64,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(AppLocalizations.of(context).noInvoicesLabel()),
          )
        ],
      ));


}