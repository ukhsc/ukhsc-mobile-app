class NetworkConfig {
  // Default timeout configurations
  static const defaultConnectTimeout = Duration(seconds: 30);
  static const defaultReceiveTimeout = Duration(seconds: 30);
  static const defaultSendTimeout = Duration(seconds: 30);
  
  // Retry configuration
  static const maxRetryAttempts = 3;
  static const minRetryDelay = Duration(seconds: 1);
  static const maxRetryDelay = Duration(seconds: 8);
  
  // Network state check configuration
  static const backgroundCheckDelay = Duration(seconds: 2);
  static const networkStateChangeDelay = Duration(milliseconds: 500);
  
  // HTTP status codes that should trigger a retry
  static const retryableStatusCodes = {
    408, // Request Timeout
    429, // Too Many Requests
    500, // Internal Server Error
    502, // Bad Gateway
    503, // Service Unavailable
    504  // Gateway Timeout
  };
  
  // Calculate retry delay with exponential backoff
  static Duration getRetryDelay(int attemptCount) {
    final delay = minRetryDelay.inSeconds * (1 << attemptCount);
    return Duration(seconds: delay).clamp(minRetryDelay, maxRetryDelay);
  }
}