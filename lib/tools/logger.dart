
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:nio_demo/tools/iterables.dart';
import 'package:stack_trace/stack_trace.dart';

void logit(dynamic value) {
  var frame = Trace.from(StackTrace.current).terse.frames;
  var trace = frame.getOrNull(1) ?? frame.firstOrNull();

  var line = trace?.line;
  var ogTraceUriData = trace?.uri;


  if (kDebugMode) {
    log("LINE -> $ogTraceUriData:$line, MESSAGE -> $value");
  }
   debugPrint(
       "LINE -> $ogTraceUriData:$line, MESSAGE -> $value",
       wrapWidth: 1024);
}
