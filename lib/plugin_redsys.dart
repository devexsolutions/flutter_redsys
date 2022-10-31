
import 'package:plugin_redsys/common/tpvv_configuration.dart';

import 'plugin_redsys_platform_interface.dart';

class PluginRedsys {

  Future<String?> webPayment(Map<String,dynamic> tpvvConfig) {
    return PluginRedsysPlatform.instance.webPayment(tpvvConfig);
  }
}
