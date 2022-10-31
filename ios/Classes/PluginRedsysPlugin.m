#import "PluginRedsysPlugin.h"
#if __has_include(<plugin_redsys/plugin_redsys-Swift.h>)
#import <plugin_redsys/plugin_redsys-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "plugin_redsys-Swift.h"
#endif

@implementation PluginRedsysPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPluginRedsysPlugin registerWithRegistrar:registrar];
}
@end
