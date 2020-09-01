import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/ui/theme.dart';

typedef SettingsSwitchCallBack = void Function(bool valueUpdate);

class SwitchFusionPreference extends StatefulWidget {
  final String title;
  final bool value;
  final SettingsSwitchCallBack onSwitch;

  SwitchFusionPreference(
      {@required this.title, @required this.value, this.onSwitch});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SwitchFusionPreferenceState();
  }
}

class _SwitchFusionPreferenceState extends State<SwitchFusionPreference> {
  bool stateValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stateValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.95;
    final cardHeight = cardWidth * 0.15;

    return GestureDetector(
      onTap: () {
        widget.onSwitch.call(!(stateValue));
        setState(() {
          stateValue = !(widget.value);
        });
      },
      child: Card(
        elevation: 3,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: FusionTheme.borderRadius),
        child: Container(
          width: cardWidth,
          height: cardHeight,
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                flex: 4,
                child: Text(widget.title),
              ),
              Flexible(
                flex: 1,
                child: PlatformSwitch(
                  value: stateValue == null ? false : stateValue,
                  onChanged: (value) {
                    widget.onSwitch.call(stateValue);
                    setState(() {
                      stateValue = !stateValue;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
