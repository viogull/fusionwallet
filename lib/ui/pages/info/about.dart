


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fusion_wallet/ui/components/custom/scaffold.dart';
import 'package:get_version/get_version.dart';

import '../../../localizations.dart';

class AboutBuildUi extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<AboutBuildUi> {
  String _platformVersion = '';
  String _projectVersion = '';
  String _projectCode = '';
  String _projectAppID = '';
  String _projectName = '';

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GetVersion.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = await GetVersion.projectVersion;
    } on PlatformException {
      projectVersion = 'Failed to get project version.';
    }

    String projectCode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectCode = await GetVersion.projectCode;
    } on PlatformException {
      projectCode = 'Failed to get build number.';
    }

    String projectAppID;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectAppID = await GetVersion.appID;
    } on PlatformException {
      projectAppID = 'Failed to get app ID.';
    }

    String projectName;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectName = await GetVersion.appName;
    } on PlatformException {
      projectName = 'Failed to get app name.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _projectVersion = projectVersion;
      _projectCode = projectCode;
      _projectAppID = projectAppID;
      _projectName = projectName;
    });
  }



  @override
  Widget build(BuildContext context) {
    return  FusionScaffold(
        title: AppLocalizations.of(context).labelBuildsAbout(),
        child: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
           Image.asset(
                    "assets/images/icon.png",
                    width: 98,
                    height: 98,
                    fit: BoxFit.contain,
                  ),
              new Container(
                height: 10.0,
              ),
              new ListTile(
                leading: new Icon(Icons.info),
                title:  Text( AppLocalizations.of(context).labelBuildName()),
                subtitle: new Text(_projectName),
              ),
              new Container(
                height: 10.0,
              ),
              new ListTile(
                leading: new Icon(Icons.info),
                title:  Text( AppLocalizations.of(context).labelBuildRunningOn()),
                subtitle: new Text(_platformVersion),
              ),
              new Divider(
                height: 20.0,
              ),
              new ListTile(
                leading: new Icon(Icons.info),
                title:  Text( AppLocalizations.of(context).labelBuildVersion()),
                subtitle: new Text(_projectVersion),
              ),
              new Divider(
                height: 20.0,
              ),
              new ListTile(
                leading: new Icon(Icons.info),
                title:  Text( AppLocalizations.of(context).labelBuildVersionCode()),
                subtitle: new Text(_projectCode),
              ),
              new Divider(
                height: 20.0,
              ),
              new ListTile(
                leading: new Icon(Icons.info),
                title:  Text( AppLocalizations.of(context).labelBuildAppId()),
                subtitle: new Text(_projectAppID),
              ),
            ],
          ),
        ),
      );
  }
}