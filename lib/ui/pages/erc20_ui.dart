



import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusion_wallet/ui/components/custom/button.dart';
import 'package:fusion_wallet/ui/components/custom/scaffold.dart';
import 'package:fusion_wallet/ui/pages/erc20/erc20_store.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:fusion_wallet/utils/flasher.dart';
import 'package:fusion_wallet/utils/haptic.dart';
import 'package:fusion_wallet/utils/io_tools.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../inject.dart';
import '../../localizations.dart';
import '../widgets.dart';


class Erc20WalletUi extends StatefulWidget {

  bool hideToolbar = false;

  Erc20WalletUi({this.hideToolbar});

  static const String navId = "/qr/share/erc20";


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Erc20WalletUiState();
  }

}


class _Erc20WalletUiState extends State<Erc20WalletUi> {
  Erc20Store store = Erc20Store();
  GlobalKey globalKey = new GlobalKey();


  String _data ='';


  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      store.init();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) {
          final isWalletExist = store.isWalletPersisted;
          debugPrint("Wallet exist? -> $isWalletExist");
          if(isWalletExist) {
            return FusionScaffold(
              title: AppLocalizations.of(context).labelErc20Wallet(),
              hideToolbar: widget.hideToolbar,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Column(
                          children: <Widget>[
                            RepaintBoundary(
                              key: globalKey ,
                              child: QrImage(
                                version: QrVersions.auto,
                                foregroundColor: Theme
                                    .of(context)
                                    .colorScheme
                                    .primary,
                                data: store.address,
                                backgroundColor: Theme
                                    .of(context)
                                    .colorScheme
                                    .surface,
                                size: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex:1,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: RaisedButton.icon(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: FusionTheme.borderRadius),
                            label: Text(
                              AppLocalizations.of(context).buttonShare(),
                              style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .onPrimary),
                            ),
                            onPressed: () {
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
                                Clipboard.setData(ClipboardData(text: store.address));
                                injector.get<HapticUtil>().success();
                                FlashHelper.successBar(context,
                                    message:
                                    AppLocalizations
                                        .of(context)
                                        .addressCopied);
//
                              },
                              child: Card(
                                  margin: const EdgeInsets.all(12),
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .surface,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: FusionTheme.borderRadius,
                                      side: BorderSide(
                                          color:
                                          Theme
                                              .of(context)
                                              .colorScheme
                                              .onSurface,
                                          width: 0.25)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Observer(
                                      builder: (context) =>
                                          AutoSizeText(
                                            store.address == null ? '' : store
                                                .address,
                                            textAlign: TextAlign.center,
                                            minFontSize: 14,
                                            maxLines: 2,
                                            maxFontSize: 24,
                                          ),
                                    ),
                                  )),
                            ),
                            GestureDetector(
                              onTap: () async {
                                FlashHelper.successBar(context,
                                    message:
                                    AppLocalizations
                                        .of(context)
                                        .addressCopied);
                                injector.get<HapticUtil>().selection();
                                IOTools.setSecureClipboardItem(_data);
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
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FusionButton(
                            text:  AppLocalizations.of(context).buttonClose(),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            expandedWidth: true,
                          )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            );
          }
          else if(!isWalletExist) {
            return _buildLoadingUi(context);
          } else if(isWalletExist == null)
            return _buildLoadingUi(context);
        return _buildLoadingUi(context);
        });
  }


  Widget _buildNoWalletsUi(BuildContext context) {
      return Material(
        color: Theme.of(context).colorScheme.surface,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(FlutterIcons.ethereum_faw5d, size: 64, color: Theme.of(context).colorScheme.secondary,),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:
                  AutoSizeText(
                      AppLocalizations.of(context).ercWalletNoExists()
                  , style: GoogleFonts.robotoCondensed().copyWith(fontSize: 24)),
                ),
                FusionButton(text: AppLocalizations.of(context).createWallet(),
                    onPressed: () {
                        final accountName = StateContainer.of(context).selectedAccount.name;
                        final pass = StateContainer.of(context).selectedAccount.pin;
                        store.createErc20Wallet(name: accountName, password: pass);
                    }, expandedWidth: true, icons: Icon(FlutterIcons.ethereum_faw5d, color: Theme.of(context).colorScheme.onPrimary,),)
              ],
            ),
          ),
        ),
      );
  }

  Widget _buildLoadingUi(BuildContext context) =>
    Material(
      color: Theme.of(context).colorScheme.surface,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: PlatformCircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );


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
}
