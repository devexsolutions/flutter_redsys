import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:plugin_redsys/common/tpvv_configuration.dart';
import 'package:plugin_redsys/common/tpvv_constants.dart';
import 'package:plugin_redsys/plugin_redsys.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pluginRedsysPlugin = PluginRedsys();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {



      TPVVConfiguration tpvvConfig = TPVVConfiguration();

      tpvvConfig.amount = "10";
      tpvvConfig.paymentMethods = TPVVConstants.PAYMENT_METHOD_T;
      tpvvConfig.license = "<dev_license_for_ios_or_android>";
      tpvvConfig.environment = TPVVConstants.ENVIRONMENT_TEST;
      tpvvConfig.fuc = "<merchant_fuc>";
      //TPVVConfiguration.setLicense("3Xe1uoMGqqFPSrsqK4xo");
      tpvvConfig.terminal = "002";
      tpvvConfig.merchantUrl = "<merchant_url_for_results_reporting>";
      tpvvConfig.currency = "978";
      tpvvConfig.merchantData = "<id_transaction_to_be_set>";

      var call = _pluginRedsysPlugin.webPayment(tpvvConfig.toJson());
      log("CALL $call");
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running'),
        ),
      ),
    );
  }
}
