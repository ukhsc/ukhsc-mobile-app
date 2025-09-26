# Store Reviewer Mode Guide

This document explains the store reviewer functionality implemented to allow Google Play and App Store reviewers to safely access the app without seeing real user data.

## Overview

The app includes a special "Store Reviewer Mode" that:
- Provides demo/sanitized data instead of real user information
- Ensures reviewers can access all app functionality
- Protects user privacy during the review process
- Follows industry best practices for app store submissions

## How It Works

### Environment Configuration

Store reviewer mode is activated when the following environment variables are set:

```bash
STORE_REVIEWER_USERNAME=reviewer_username
STORE_REVIEWER_PASSWORD=reviewer_password
STORE_REVIEWER_REFRESH_TOKEN=special_reviewer_token
```

When `STORE_REVIEWER_REFRESH_TOKEN` is present, `AppEnvironment.isStoreReviewerMode` returns `true`.

### Reviewer Access

1. **Access Method**: Reviewers access the special login by tapping the app bar 5 times within 5 seconds on the get started page
2. **Credentials**: Reviewers use the configured username and password
3. **Fallback**: If backend token refresh fails, the app uses a fallback mechanism to ensure reviewers can always access the app

### Demo Data

When in reviewer mode, the app shows:

- **Demo School**: "示範高中" (Demo High School)
- **Demo User**: reviewer@demo.ukhsc.org
- **Demo Member ID**: DEMO-MEMBER-ID
- **Demo Nickname**: "審查員" (Reviewer)
- **Demo Barcode**: /DEMO999

### UI Changes

- Home page greeting changes to "XX安，審查員" (Good XX, Reviewer)
- Welcome message becomes "歡迎體驗應用程式功能" (Welcome to experience app features)
- All personal data is replaced with clearly marked demo data

## Security Features

1. **Data Isolation**: Reviewer sessions are completely isolated from real user data
2. **Demo Data Service**: Centralized service provides consistent demo data
3. **No Real Data Exposure**: Reviewers never see actual user emails, names, or student information
4. **Clear Indicators**: Demo data is clearly marked as such

## Backend Coordination

The backend should:
1. Provide a long-lived or non-expiring refresh token for reviewers
2. Create a dedicated reviewer account with demo data
3. Ensure the reviewer account cannot access real user information
4. Support the `/auth/token/refresh` endpoint for reviewer tokens

## Testing Reviewer Mode

To test reviewer mode in development:

1. Set the environment variables:
   ```bash
   export STORE_REVIEWER_USERNAME="test_reviewer"
   export STORE_REVIEWER_PASSWORD="test_password"
   export STORE_REVIEWER_REFRESH_TOKEN="demo_refresh_token"
   ```

2. Build the app with these environment variables

3. Access the reviewer login by tapping the app bar 5 times quickly

4. Login with the configured credentials

5. Verify that all displayed data is demo data

## Files Modified

- `lib/core/env.dart` - Added reviewer mode detection
- `lib/core/services/demo_data_service.dart` - Demo data provider
- `lib/features/auth/data/auth_repository.dart` - Reviewer mode handling
- `lib/features/membership/data/member_repository.dart` - Demo member data
- `lib/features/onboarding/presentation/widgets/store_reviewer_sheet.dart` - Enhanced authentication
- `lib/features/home/presentation/home_page.dart` - Reviewer mode UI

## Best Practices

1. **Never** log real user data in reviewer mode
2. **Always** verify that demo data is clearly marked as such
3. **Regularly** test the reviewer flow to ensure it works
4. **Coordinate** with backend team for reviewer token management
5. **Document** any new data that needs demo equivalents

## Troubleshooting

### Reviewer Can't Login
- Check environment variables are set correctly
- Verify backend reviewer token is valid
- Check app logs for authentication errors
- Ensure fallback mechanism is working

### Real Data Showing in Reviewer Mode
- Verify `AppEnvironment.isStoreReviewerMode` returns `true`
- Check that all data services check reviewer mode
- Add demo data for any new data types

### Backend Token Issues
- Implement non-expiring tokens for reviewers
- Ensure reviewer tokens are separate from user tokens
- Add proper error handling for token refresh failures