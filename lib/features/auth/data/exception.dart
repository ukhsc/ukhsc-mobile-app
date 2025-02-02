import 'package:ukhsc_mobile_app/core/error/exception.dart';

class InvalidGrantException extends AppException {
  InvalidGrantException({super.originalError, super.stackTrace})
      : super(userReadableMessage: 'Google 校園帳號授權無效，請再試一次。');
}

class CredentialExpiredException extends AppException {
  CredentialExpiredException({super.originalError, super.stackTrace})
      : super(userReadableMessage: '登入憑證已過期，請重新登入。');
}

class InvalidCredentialException extends AppException {
  InvalidCredentialException({super.originalError, super.stackTrace})
      : super(userReadableMessage: '會員登入憑證無效，請重新登入。');
}

class BannedLoginException extends AppException {
  BannedLoginException({super.originalError, super.stackTrace})
      : super(userReadableMessage: '您的帳號已被停權，如有疑問請聯繫我們。');
}
