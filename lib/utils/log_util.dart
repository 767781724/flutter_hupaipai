import 'package:logger/logger.dart';

class LogUtil {
  static final instance = Logger();

  /// Log a message at level [Level.verbose].
  static void v(dynamic message, [dynamic error, StackTrace stackTrace]) {
    instance.v(message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  static void d(dynamic message, [dynamic error, StackTrace stackTrace]) {
    instance.d(message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  static void i(dynamic message, [dynamic error, StackTrace stackTrace]) {
    instance.i(message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  static void w(dynamic message, [dynamic error, StackTrace stackTrace]) {
    instance.w(message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  static void e(dynamic message, [dynamic error, StackTrace stackTrace]) {
    instance.e(message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  static void wtf(dynamic message, [dynamic error, StackTrace stackTrace]) {
    instance.wtf(message, error, stackTrace);
  }
}
