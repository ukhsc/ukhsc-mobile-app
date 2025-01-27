// ignore_for_file: constant_identifier_names

/// Machine readable error api codes for known errors which usually caused by the requester (frontend).
///
/// The error code is a string in the format of "UXXXX", where "U" stands for "UKHSC System",
/// and "XXXX" is a 4-digit number.
///
/// ### Code Ranges:
/// - 1000 ~ 1999: Basic CRUD operations
/// - 2000 ~ 2999: Authentication and Authorization
/// - 3000 ~ 3999: User management
/// - 4000 ~ 4999: Membership management
/// - 5000 ~ 5999: Partner shops management
/// - 6000 ~ 6999: External services
/// - 7000 ~ 7999: Data validation
/// - 8000 ~ 9999: Miscellaneous
enum KnownErrorCode {
  // 1000 ~ 1999: Basic CRUD operations
  NOT_FOUND('U1000'),
  MISMATCH('U1001'),

  // 2000 ~ 2999: Authentication and Authorization
  NO_TOKEN('U2000'),
  INVALID_TOKEN('U2001'),
  BANNED_USER('U2002'),
  INSUFFICIENT_PERMISSIONS('U2003'),
  ACCESS_REVOKED('U2004'),
  UNAUTHORIZED_DEVICE('U2005'),

  // 3000 ~ 3999: User management
  INVALID_FEDERATED_GRANT('U3000'),
  FEDERATED_LINKED('U3001'),
  FEDERATED_NOT_LINKED('U3002'),

  // 4000 ~ 4999: Membership management
  INVALID_SCHOOL_EMAIL('U4000');

  final String code;
  const KnownErrorCode(this.code);

  static KnownErrorCode? fromJson(String json) {
    return KnownErrorCode.values.cast<KnownErrorCode?>().firstWhere(
          (e) => e?.code == json,
          orElse: () => null,
        );
  }
}
