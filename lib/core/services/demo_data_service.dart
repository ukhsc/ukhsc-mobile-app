import 'package:ukhsc_mobile_app/features/auth/models/user.dart';
import 'package:ukhsc_mobile_app/features/auth/models/school.dart';
import 'package:ukhsc_mobile_app/features/membership/model/student_member.dart';

/// Service that provides sanitized demo data for store reviewers
/// This ensures reviewers never see real user data
class DemoDataService {
  static const _demoSchool = PartnerSchool(
    id: 999,
    name: '示範高中',
    shortName: '示範高中',
    logoUrl: null,
    description: '這是一個示範學校，用於商店審查者體驗應用程式功能。',
    config: SchoolConfig(
      redirectUri: 'https://demo.ukhsc.org/callback',
      googleWorkspaceHostedDomain: 'demo.ukhsc.org',
    ),
  );

  static final _demoUser = User(
    id: 999999,
    primaryEmail: 'reviewer@demo.ukhsc.org',
    createdAt: DateTime(2024, 1, 1),
    updatedAt: DateTime(2024, 1, 1),
    roles: [UserRole.studentMember],
  );

  static const _demoMemberSettings = MemberSettings(
    nickname: '審查員',
    eInvoiceBarcode: '/DEMO999',
  );

  static final StudentMember _demoStudentMember = StudentMember(
    'DEMO-MEMBER-ID',
    999, // schoolAttendedId
    999999, // userId
    'DEMO-STUDENT-ID-HASH',
    DateTime(2024, 1, 1), // createdAt
    DateTime(2024, 1, 1), // activatedAt
    DateTime(2025, 12, 31), // expiredAt
    true, // isActivated
    _demoSchool,
    _demoMemberSettings,
  );

  /// Returns demo user data for store reviewers
  static User getDemoUser() {
    return _demoUser;
  }

  /// Returns demo school data for store reviewers
  static PartnerSchool getDemoSchool() {
    return _demoSchool;
  }

  /// Returns demo student member data for store reviewers
  static StudentMember getDemoStudentMember() {
    return _demoStudentMember;
  }

  /// Returns a list of demo schools for the school selection screen
  static List<SchoolWithConfig> getDemoSchools() {
    return [
      _demoSchool,
      const PartnerSchool(
        id: 998,
        name: '範例高中',
        shortName: '範例高中',
        logoUrl: null,
        description: '另一個示範學校。',
        config: SchoolConfig(
          redirectUri: 'https://demo.ukhsc.org/callback',
          googleWorkspaceHostedDomain: 'example.ukhsc.org',
        ),
      ),
      const PartnerSchool(
        id: 997,
        name: '測試高中',
        shortName: '測試高中',
        logoUrl: null,
        description: '用於測試的示範學校。',
        config: SchoolConfig(
          redirectUri: 'https://demo.ukhsc.org/callback',
          googleWorkspaceHostedDomain: 'test.ukhsc.org',
        ),
      ),
    ];
  }
}