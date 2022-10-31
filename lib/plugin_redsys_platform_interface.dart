import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:plugin_redsys/common/tpvv_configuration.dart';

import 'plugin_redsys_method_channel.dart';

abstract class PluginRedsysPlatform extends PlatformInterface {
  /// Constructs a PluginRedsysPlatform.
  PluginRedsysPlatform() : super(token: _token);

  static final Object _token = Object();

  static PluginRedsysPlatform _instance = MethodChannelPluginRedsys();

  /// The default instance of [PluginRedsysPlatform] to use.
  ///
  /// Defaults to [MethodChannelPluginRedsys].
  static PluginRedsysPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PluginRedsysPlatform] when
  /// they register themselves.
  static set instance(PluginRedsysPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }


  Future<String?> webPayment(Map<String,dynamic> config) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
