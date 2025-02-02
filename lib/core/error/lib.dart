import 'package:flutter/foundation.dart';

import '../env.dart';

export 'app_error_event.dart';
export 'error_severity.dart';
export 'error_service.dart';
export 'error_extension.dart';

bool kEnableSentry = kReleaseMode && AppEnvironment.sentryDSN != null;
