#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(SplashScreenPlugin, "SplashScreen",
           CAP_PLUGIN_METHOD(show, CAPPluginReturnPromise);
           // Show and update progress of progress bar.
           CAP_PLUGIN_METHOD(updateProgress, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(hide, CAPPluginReturnPromise);
)
