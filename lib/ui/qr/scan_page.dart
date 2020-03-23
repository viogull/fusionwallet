import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/localizations.dart';

class ScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScanPageState();
  }
}

class _ScanPageState extends State<ScanPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PlatformScaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: PlatformAppBar(
              title: AppLocalizations.of(context).toolbarScanQrTitle(),
              android: (_) => MaterialAppBarData(centerTitle: true),
              ios: (_) => CupertinoNavigationBarData(),
            ),
          ),
        ],
      ),
    );
  }
}
