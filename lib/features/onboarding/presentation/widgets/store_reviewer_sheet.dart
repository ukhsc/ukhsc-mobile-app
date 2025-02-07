import 'dart:io';

import 'package:flutter/material.dart'
    show Form, TextFormField, InputDecoration, OutlineInputBorder;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ukhsc_mobile_app/components/lib.dart';
import 'package:ukhsc_mobile_app/core/api/lib.dart';
import 'package:ukhsc_mobile_app/core/env.dart';
import 'package:ukhsc_mobile_app/core/style/lib.dart';
import 'package:ukhsc_mobile_app/features/auth/data/auth_data_source.dart';
import 'package:ukhsc_mobile_app/features/auth/lib.dart';
import 'package:ukhsc_mobile_app/features/home/lib.dart';

class StoreReviewerSheet extends StatefulHookConsumerWidget {
  const StoreReviewerSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StoreReviewerSheetState();
}

class _StoreReviewerSheetState extends ConsumerState<StoreReviewerSheet> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();
    final isConfigured = AppEnvironment.storeReviewerUsername != null &&
        AppEnvironment.storeReviewerPassword != null &&
        AppEnvironment.storeReviewerRefreshToken != null;

    if (!isConfigured) {
      return Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.symmetric(
            horizontal: theme.spaces.xl, vertical: theme.spaces.md),
        child: Column(
          children: [
            Text('Warning', style: theme.text.common.headlineLarge),
            Text(
              'Store reviewer credentials are not configured.',
              style: theme.text.common.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final isLoading = useState(false);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: theme.spaces.xl, vertical: theme.spaces.md),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: theme.spaces.lg,
          children: [
            Text('Welcome, dear Reviewer',
                style: theme.text.common.headlineLarge),
            Text(
              'This login is exclusively for ${Platform.isIOS ? 'App Store' : 'Google Play'} reviewers to access and evaluate the app\'s functionalities. Please use the provided credentials.',
              style: theme.text.common.bodyMedium,
              textAlign: TextAlign.center,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }

                if (value != AppEnvironment.storeReviewerUsername) {
                  return 'Invalid username';
                }

                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }

                if (value != AppEnvironment.storeReviewerPassword) {
                  return 'Invalid password';
                }
                return null;
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.spaces.md),
              child: ComposableButton(
                onPressed: () async {
                  isLoading.value = true;
                  await _onPressed();
                  isLoading.value = false;
                },
                style: FilledStyle.dark(),
                content: Text('Login')
                    .asButtonContent
                    .withExpanded()
                    .withLoading(isLoading.value),
              ),
            ),
            Text(
              '本頁面是設計給應用程式商店的審查者使用，如果您不小心來到這裡，請關閉本頁面，感謝。',
              style: theme.text.common.labelMedium,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPressed() async {
    if (!_formKey.currentState!.validate()) return;

    final dataSource = AuthDataSource(api: ref.read(apiClientProvider));
    final repo = ref.read(authRepositoryProvider);

    // TODO: Generate a non-expiring refresh token for the reviewer.
    final credential = await dataSource.refreshToken(
        refreshToken: AppEnvironment.storeReviewerRefreshToken!);
    await repo.saveCredential(credential);

    if (await repo.hasCredential() && mounted) {
      HomeRoute().go(context);
    } else {
      OverlayMessage.show('Invalid credentials or network error');
    }
  }
}
