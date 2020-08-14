import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_wallet/ui/theme.dart';

typedef OnSingleChoiceSelected = void Function(int index);

class FusionSingleChoicePreference extends StatefulWidget {
  final String title;
  final List<String> items;
  final String selected;
  final OnSingleChoiceSelected onSelected;

  FusionSingleChoicePreference(
      {@required this.title,
      @required this.items,
      @required this.selected,
      @required this.onSelected});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FusionSingleChoicePreferenceState();
  }
}

class _FusionSingleChoicePreferenceState
    extends State<FusionSingleChoicePreference> {
  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.95;
    final cardHeight = cardWidth * 0.15;
    String dropdownValue;

    return Card(
      elevation: 3,
      color: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(borderRadius: FusionTheme.borderRadius),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Text(widget.title),
            ),
            Flexible(
                flex: 2,
                child: DropdownButton<String>(

                  dropdownColor: Theme.of(context).colorScheme.surface.withOpacity(0.7),
                  value:
                      dropdownValue == null ? widget.selected : dropdownValue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 20,
                  elevation: 0,
                  style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7)),
                  onChanged: (String newValue) {
                    final index = widget.items.indexOf(newValue);
                    widget.onSelected(index);
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: widget.items
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Material(
                        borderOnForeground: false,
                        elevation: 0,
                        color: Theme.of(context).colorScheme.background,
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          child: AutoSizeText(
                            value,
                            minFontSize: 8,
                            maxFontSize: 12,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ))
          ],
        ),
      ),
    );
  }
}
