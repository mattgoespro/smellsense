import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class CustomLogPrinter extends PrettyPrinter {
  CustomLogPrinter({
    super.lineLength = 150,
    super.colors = true,
    super.printEmojis = true,
    super.methodCount = 0,
    super.errorMethodCount = 5,
    super.dateTimeFormat = DateTimeFormat.dateAndTime,
    super.excludeBox = const {
      Level.info: true,
      Level.trace: true,
    },
    /*
     * Exclude the stack trace locations that are sourced in the wrapper class where
     * the logger using this printer is being accessed from.
     */
    super.stackTraceBeginIndex = 1,
  });

  @override
  List<String> log(LogEvent event) {
    List<String> logLines = super.log(event);
    return logLines;
  }

  @override
  String stringifyMessage(dynamic message) => stringifyClassObject(message);

  String stringifyClassObject(dynamic object) => object.toString();
}

class Output {
  static Logger logger = Logger(
    printer: CustomLogPrinter(),
    output: ConsoleOutput(),
    filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
  );

  static trace(dynamic message) {
    logger.t(message);
  }

  static debug(dynamic message) {
    logger.d(message);
  }

  static info(dynamic message) {
    logger.i(message);
  }

  static warn(dynamic message) {
    logger.w(message);
  }

  static error(dynamic exception) {
    logger.e(exception);
  }
}
