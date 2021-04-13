import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

bool get isIOS => Platform.isIOS;

Future<void> logErrorOnFirebase(
    dynamic error,
    StackTrace stackTrace, {
      bool printDetails = false,
    }) async {
  if (kReleaseMode) {
    await FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      printDetails: printDetails,
    );
  }
}

extension StringUtils on String {
  String capitalize() => "${this[0].toUpperCase()}${this.substring(1)}";
}