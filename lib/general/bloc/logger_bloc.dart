import 'dart:async';
import 'dart:developer' as dev;

import 'package:contacts/general/app_state.dart';
import 'package:contacts/general/util/build_mode.dart';
import 'package:intl/intl.dart';
import 'package:rebloc/rebloc.dart';

class LoggerBloc extends SimpleBloc<AppState> {
  @override
  FutureOr<Action> middleware(DispatchFunction dispatcher, AppState state, Action action) {
    _printLog(action);
    return action;
  }

  void _printLog(Action action) {
    if (BuildMode.isDebug) {
      log("========================Action=========================");
      final now = DateTime.now();
      log(DateFormat('kk:mm:ss SSS').format(now) + " " + action.runtimeType.toString());

      log("=======================================================");
    }
  }

  void log(dynamic logMessage, {String name = 'log', dynamic error, dynamic stackTrace}) {
    if (BuildMode.isDebug) {
      dev.log(logMessage.toString(), name: name, error: error, stackTrace: stackTrace);
    }
  }
}
