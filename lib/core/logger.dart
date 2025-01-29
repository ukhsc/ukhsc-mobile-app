import 'package:logging/logging.dart';

class AppLogger {
  static final Map<String, Logger> _loggers = {};

  static Logger getLogger(String name) {
    return _loggers.putIfAbsent(name, () => Logger(name));
  }
}
