import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusion_wallet/utils/io_tools.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../inject.dart';
import '../../localizations.dart';
import '../theme.dart';
import '../widgets.dart';
import 'erc20_ui.dart';

class ShareAddressPage extends StatefulWidget {


  static const String navId = "/qr/share";

  final String _data;

  const ShareAddressPage(this._data);

  @override
  State<StatefulWidget> createState() {
    return ShareAddressState();
  }
}


class ShareAddressState extends State<ShareAddressPage> with  SingleTickerProviderStateMixin {

  TabController _tabController;
  GlobalKey globalKey = new GlobalKey();

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return FusionScaffold(
      title: AppLocalizations.of(context).buttonShare(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar:         _buildTabs(context),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: TabBarView(
            controller: _tabController,
            physics: BouncingScrollPhysics(),
            children: [
              _buildMinterSharePage(context),
              Erc20WalletUi(hideToolbar: true)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
      globalKey.currentContext.findRenderObject();
      final image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      Share.file('Secure', 'image.png', pngBytes, 'image/png');
    } catch (e) {
      print(e.toString());
    }
  }
  Widget _buildMinterSharePage(BuildContext context) => Container(
    height: MediaQuery.of(context).size.height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Column(
              children: <Widget>[
                RepaintBoundary(
                  key: globalKey,
                  child: QrImage(
                    version: QrVersions.auto,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    data: widget._data,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    size: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton.icon(
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: FusionTheme.borderRadius),
                label: Text(
                  AppLocalizations.of(context).buttonShare(),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                onPressed: () async {
                   _captureAndSharePng();
                },
                icon: Container(
                  child: SvgPicture.asset(
                    'assets/images/icons/ic_shareicon.svg',
                    color: Colors.white,
                  ),
                  width: 18,
                  height: 18,
                )),
          ),
        ),
        Flexible(
            flex: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: widget._data));
                    injector.get<HapticUtil>().selection();
                    FlashHelper.successBar(context,
                        message:
                        AppLocalizations.of(context).addressCopied);
//                        Fluttertoast.showToast(
//                            msg: AppLocalizations.of(context).labelOk());
                  },
                  child: Card(
                      margin: const EdgeInsets.all(4),
                      color: Theme.of(context).colorScheme.surface,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: FusionTheme.borderRadius,
                          side: BorderSide(
                              color:
                              Theme.of(context).colorScheme.onSurface,
                              width: 0.25)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: AutoSizeText(
                          widget._data,
                          textAlign: TextAlign.center,
                          minFontSize: 12,
                          maxLines: 2,
                          maxFontSize: 16,
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () async {
                    FlashHelper.successBar(context,
                        message:
                        AppLocalizations.of(context).addressCopied);
                    injector.get<HapticUtil>().selection();
                    IOTools.setSecureClipboardItem(widget._data);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: AutoSizeText(
                      AppLocalizations.of(context).labelTapToCopy(),
                      textAlign: TextAlign.center,
                      minFontSize: 8,
                      maxLines: 1,
                      maxFontSize: 14,
                    ),
                  ),
                )
              ],
            )),
        Flexible(
          flex: 2,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:        FusionButton(
                text:  AppLocalizations.of(context).buttonClose(),
                expandedWidth: true,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    ),
  );


  Widget _buildTabs(BuildContext context) {
    return new TabBar(
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Theme.of(context).colorScheme.onBackground,
      unselectedLabelColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
      labelStyle: GoogleFonts.robotoCondensed(fontSize: 16 ),
      physics: ClampingScrollPhysics(),
      indicator:  BubbleTabIndicator(
        indicatorRadius: 5,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        indicatorColor: Theme.of(context).colorScheme.surface,
        tabBarIndicatorSize: TabBarIndicatorSize.label,

      ),
      controller: _tabController,
      tabs: [
        Tab(text: AppLocalizations.of(context).labelMinterWallet(), icon: SvgPicture.asset("assets/images/icons/minter.svg", width: 24,height: 24,)),
        Tab(text: AppLocalizations.of(context).labelErc20Wallet(), icon: Icon(FlutterIcons.ethereum_faw5d))
      ],
    );
  }
}
