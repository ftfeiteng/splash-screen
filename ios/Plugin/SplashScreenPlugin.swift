import Foundation
import Capacitor

@objc(SplashScreenPlugin)
public class SplashScreenPlugin: CAPPlugin {
    private var splashScreen: SplashScreen?

    override public func load() {
        if let view = bridge?.viewController?.view {
            splashScreen = SplashScreen(parentView: view, config: splashScreenConfig())
            splashScreen?.showOnLaunch()
        }
    }

    // Show the splash screen
    @objc public func show(_ call: CAPPluginCall) {
        if let splash = splashScreen {
            let settings = splashScreenSettings(from: call)
            splash.show(settings: settings,
                        completion: {
                            call.resolve()
                        })
        } else {
            call.reject("Unable to show Splash Screen")
        }

    }

    // Show and update progress of progress bar.
    @objc public func updateProgress(_ call: CAPPluginCall) {
        if let splash = splashScreen {
            splash.updateProgress(percentage: call.getFloat("progress", 0))
            call.resolve()
        } else {
            call.reject("Unable to hide Splash Screen")
        }
    }

    // Hide the splash screen
    @objc public func hide(_ call: CAPPluginCall) {
        if let splash = splashScreen {
            let settings = splashScreenSettings(from: call)
            splash.hide(settings: settings)
            call.resolve()
        } else {
            call.reject("Unable to hide Splash Screen")
        }
    }

    private func splashScreenSettings(from call: CAPPluginCall) -> SplashScreenSettings {
        var settings = SplashScreenSettings()

        if let showDuration = call.getInt("showDuration") {
            settings.showDuration = showDuration
        }
        if let fadeInDuration = call.getInt("fadeInDuration") {
            settings.fadeInDuration = fadeInDuration
        }
        if let fadeOutDuration = call.getInt("fadeOutDuration") {
            settings.fadeOutDuration = fadeOutDuration
        }
        if let autoHide = call.getBool("autoHide") {
            settings.autoHide = autoHide
        }
        return settings
    }

    private func splashScreenConfig() -> SplashScreenConfig {
        var config = SplashScreenConfig()

        if let backgroundColor = getConfig().getString("backgroundColor") {
            config.backgroundColor = UIColor.capacitor.color(fromHex: backgroundColor)
        }
        if let spinnerStyle = getConfig().getString("iosSpinnerStyle") {
            switch spinnerStyle.lowercased() {
            case "small":
                config.spinnerStyle = .medium
            default:
                config.spinnerStyle = .large
            }
        }
        if let spinnerColor = getConfig().getString("spinnerColor") {
            config.spinnerColor = UIColor.capacitor.color(fromHex: spinnerColor)
        }
        config.showSpinner = getConfig().getBoolean("showSpinner", config.showSpinner)

        config.launchShowDuration = getConfig().getInt("launchShowDuration", config.launchShowDuration)
        config.launchAutoHide = getConfig().getBoolean("launchAutoHide", config.launchAutoHide)
        config.animated = getConfig().getBoolean("animated", config.animated)
        // Play the multiple image frames across the amount of milliseconds specified.
        config.launchAnimationDuration = getConfig().getInt("launchAnimationDuration", config.launchAnimationDuration)
        return config
    }

}
