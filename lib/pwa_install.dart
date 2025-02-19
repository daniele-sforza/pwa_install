library;

import 'package:flutter/foundation.dart';
import 'package:pwa_install/js_stub.dart'
    if (dart.library.js_interop) 'dart:js_interop';

/// Functions that are called from JavaScript
/// Three parts:
/// 1. external set _functionName(void Function() f);
/// 2. external void functionName();
/// 3. The actual Dart function
///
/// Function that gets called from JavaScript code if app was launched as a PWA
@JS()
external set appLaunchedAsPWA(JSFunction f);

void setLaunchModePWA() {
  debugPrint('Launched as PWA');
  PWAInstall().launchMode = LaunchMode.pwa;
}

/// Function that gets called from JavaScript code if app was launched as a TWA
@JS()
external set appLaunchedAsTWA(JSFunction f);

void setLaunchModeTWA() {
  debugPrint('Launched as TWA');
  PWAInstall().launchMode = LaunchMode.twa;
}

/// Function that gets called from JavaScript when a install prompt has been detected
@JS("hasPrompt")
external set _hasPrompt(JSFunction f);

@JS()
external void hasPrompt();

void setHasPrompt() {
  debugPrint('Browser has install prompt');
  PWAInstall().hasPrompt = true;
}

/// Function that gets called from JavaScript when the app is installed as a PWA
@JS()
external set appInstalled(JSFunction f);

/// Function that gets called from JavaScript code if app was launched from a browser
@JS()
external set appLaunchedInBrowser(JSFunction f);

void setLaunchModeBrowser() {
  debugPrint('Launched in Browser');
  PWAInstall().launchMode = LaunchMode.browser;
}

/// JavaScript functions that are called from Dart
/// Show the PWA install prompt if it exists
@JS("promptInstall")
external void promptInstall();

/// Fetch the launch mode of the app from JavaScript
/// The launch mode is determined by checking the display-mode media query value
/// https://web.dev/customize-install/#track-how-the-pwa-was-launched
@JS("getLaunchMode")
external void getLaunchMode();

class PWAInstall {
  static final PWAInstall _pwaInstall = PWAInstall._internal();

  factory PWAInstall() {
    return _pwaInstall;
  }

  PWAInstall._internal();

  /// This value will be true if the browser attempted to prompt the user to install the app as a PWA
  /// If the browser did not attempt to show the install prompt, the beforeinstallprompt event was not received
  /// and this Flutter package will not be able to show a new prompt
  bool hasPrompt = false;

  /// The LaunchMode of the app indicates how the app was launched. This may be as a PWA/TWA or in the browser
  LaunchMode? launchMode;

  /// An optional callback that will be fired when the user installs your app as a PWA from the install prompt
  Function? onAppInstalled;

  /// installPromptEnabled will be true if the app was not already launched as a PWA or TWA and
  /// the browser prompted the user to install the app already. The browser needs to have presented the
  /// prompt because we are capturing that event and reusing it
  bool get installPromptEnabled =>
      hasPrompt && launchMode != LaunchMode.pwa && launchMode != LaunchMode.twa;

  void getLaunchMode_() => getLaunchMode();

  void promptInstall_() {
    if (hasPrompt) {
      promptInstall();
    } else {
      throw 'This platform or browser does not support the PWA install prompt';
    }
  }

  void setup({Function? installCallback}) {
    if (!kIsWeb) return;

    // JavaScript code may now call `appLaunchedAsPWA()` or `window.appLaunchedAsPWA()`.
    appLaunchedAsPWA = setLaunchModePWA.toJS;
    // JavaScript code may now call `appLaunchedInBrowser()` or `window.appLaunchedInBrowser()`.
    appLaunchedInBrowser = setLaunchModeBrowser.toJS;
    // JavaScript code may now call `appLaunchedAsTWA()` or `window.appLaunchedAsTWA()`.
    appLaunchedAsTWA = setLaunchModeTWA.toJS;
    _hasPrompt = setHasPrompt.toJS;
    appInstalled = () {
      if (onAppInstalled != null) onAppInstalled!();
    }.toJS;
    getLaunchMode_();
    onAppInstalled = installCallback;
  }
}

enum LaunchMode {
  pwa(
    shortLabel: 'PWA',
    longLabel: 'Progressive Web App',
    installed: true,
  ),
  twa(
    shortLabel: 'TWA',
    longLabel: 'Trusted Web Activity',
    installed: true,
  ),
  browser(
    shortLabel: 'Browser',
    longLabel: 'Browser',
    installed: false,
  );

  const LaunchMode({
    required this.shortLabel,
    required this.longLabel,
    required this.installed,
  });

  /// Short name for this launch mode
  final String shortLabel;

  /// Full name for this launch mode
  final String longLabel;

  /// True if the app has been installed on the user's device
  final bool installed;
}
