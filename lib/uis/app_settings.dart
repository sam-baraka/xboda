import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  CSWidgetStyle brightnessStyle = const CSWidgetStyle(
      icon: const Icon(Icons.brightness_medium, color: Colors.black54));
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
            previousPageTitle: "Home", largeTitle: Text("Settings")),
        SliverFillRemaining(
            child: CupertinoSettings(items: <Widget>[
          const CSHeader('Account'),
          CSButton(CSButtonType.DEFAULT, "View my profile", () {
            print("It works!");
          }),
          CSButton(CSButtonType.DEFAULT, "Payment options", () {
            print("It works!");
          }),
          const CSHeader('Appearance'),
          CSWidget(CupertinoSlider(value: 0.5), style: brightnessStyle),
          CSControl(
            nameWidget: Text('Auto brightness'),
            contentWidget: CupertinoSwitch(value: true),
            style: brightnessStyle,
          ),
          CSHeader('Selection'),
          CSSelection<int>(
            items: const <CSSelectionItem<int>>[
              CSSelectionItem<int>(text: 'Day mode', value: 0),
              CSSelectionItem<int>(text: 'Night mode', value: 1),
            ],
            onSelected: (index) {
              print(index);
            },
            currentSelection: 0,
          ),
          CSDescription(
            'Using Night mode extends battery life on devices with OLED display',
          ),
          const CSHeader(''),
          CSControl(
            nameWidget: Text('Loading...'),
            contentWidget: CupertinoActivityIndicator(),
          ),
          CSButton(CSButtonType.DEFAULT, "Licenses", () {
            
            print("Licenses!");
          }),
          CupertinoContextMenu(actions: [
            CupertinoButton(child:Text("Leave the app"), onPressed: () {},),
            CupertinoButton(child:Text("Leave the app"), onPressed: () {},),
            CupertinoButton(child:Text("Leave the app"), onPressed: () {},),

          ], child: CupertinoButton(child: Icon(Icons.more_vert),onPressed:(){})),
          const CSHeader(''),
          CSButton(CSButtonType.DESTRUCTIVE, "Delete all data", () {})
        ]))
      ],
    ));
  }
}
