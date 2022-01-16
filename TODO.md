# Investigate

- W/FlutterActivityAndFragmentDelegate( 6177): A splash screen was provided to Flutter, but this is deprecated. See flutter.dev/go/android-splash-migration for migration steps.
- <code>W/ConnectionTracker( 6177): Exception thrown while unbinding
  W/ConnectionTracker( 6177): java.lang.IllegalArgumentException: Service not registered: lm@ee9b7e0
  W/ConnectionTracker( 6177): at android.app.LoadedApk.forgetServiceDispatcher(LoadedApk.java:1757)
  W/ConnectionTracker( 6177): at android.app.ContextImpl.unbindService(ContextImpl.java:1874)
  W/ConnectionTracker( 6177): at android.content.ContextWrapper.unbindService(ContextWrapper.java:792)
  W/ConnectionTracker( 6177): at ce.b(:com.google.android.gms.dynamite_measurementdynamite@201817052@20.18.17 (040700-0):1)
  W/ConnectionTracker( 6177): at ce.a(:com.google.android.gms.dynamite_measurementdynamite@201817052@20.18.17 (040700-0):5)
  W/ConnectionTracker( 6177): at ln.A(:com.google.android.gms.dynamite_measurementdynamite@201817052@20.18.17 (040700-0):10)
  W/ConnectionTracker( 6177): at ky.a(:com.google.android.gms.dynamite_measurementdynamite@201817052@20.18.17 (040700-0):3)
  W/ConnectionTracker( 6177): at dy.run(:com.google.android.gms.dynamite_measurementdynamite@201817052@20.18.17 (040700-0):2)
  </code>
- Click on _About_: A resource failed to call release.
- E2E Tests
- Custom build script with code check.
- Use new OAuth2 gmail mailing service for bug reports.
