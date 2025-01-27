import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart' show InkWell;

import 'package:ukhsc_mobile_app/core/style/lib.dart';

enum NavigationPage {
  home,
  map,
  store,
  profile,
}

class NavigationBar extends StatefulHookConsumerWidget {
  const NavigationBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavigationBarState();
}

class _NavigationBarState extends ConsumerState<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();
    final selectedPage = useState(NavigationPage.home);

    return SizedBox(
      height: 80,
      child: Stack(
        clipBehavior: Clip.none, // Allow the card to overflow
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black.withValues(alpha: 0.1)),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: theme.spaces.md)
                  .add(EdgeInsets.only(top: theme.spaces.xs)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLeftNavigation(selectedPage),
                  _buildRightNavigation(selectedPage),
                ],
              ),
            ),
          ),
          Positioned(
            top: -20,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: _buildMembershipCard(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipCard() {
    final theme = useTheme();
    final isPressed = useState(false);

    return Column(
      spacing: theme.spaces.xs,
      children: [
        GestureDetector(
          onTapDown: (_) => isPressed.value = true,
          onTapUp: (_) => isPressed.value = false,
          onTapCancel: () => isPressed.value = false,
          child: AnimatedScale(
            scale: isPressed.value ? 0.95 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.all(theme.radii.extraLarge),
              child: Container(
                padding: EdgeInsets.all(theme.spaces.md),
                decoration: BoxDecoration(
                  color: theme.colors.primary,
                  borderRadius: BorderRadius.all(theme.radii.extraLarge),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colors.primary.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.credit_card_rounded,
                  size: theme.spaces.xl,
                  color: theme.colors.primaryBackground,
                ),
              ),
            ),
          ),
        ),
        Text(
          '數位會員卡',
          style: theme.text.common.bodyMedium.copyWith(
            color: theme.colors.iconColor,
          ),
        ),
      ],
    );
  }

  Widget _buildLeftNavigation(ValueNotifier<NavigationPage> selectedPage) {
    return Row(
      children: [
        NavigationItem(
          title: '首頁',
          selectedIcon: Icons.home_rounded,
          unselectedIcon: Icons.home_outlined,
          page: NavigationPage.home,
          selectedPage: selectedPage,
          onTap: () => selectedPage.value = NavigationPage.home,
        ),
        NavigationItem(
          title: '地圖',
          selectedIcon: Icons.map_rounded,
          unselectedIcon: Icons.map_outlined,
          page: NavigationPage.map,
          selectedPage: selectedPage,
          onTap: () => selectedPage.value = NavigationPage.map,
        ),
      ],
    );
  }

  Widget _buildRightNavigation(ValueNotifier<NavigationPage> selectedPage) {
    return Row(
      children: [
        NavigationItem(
          title: '店家',
          selectedIcon: Icons.storefront_rounded,
          unselectedIcon: Icons.storefront_outlined,
          page: NavigationPage.store,
          selectedPage: selectedPage,
          onTap: () => selectedPage.value = NavigationPage.store,
        ),
        NavigationItem(
          title: '帳號',
          selectedIcon: Icons.person_rounded,
          unselectedIcon: Icons.person_outlined,
          page: NavigationPage.profile,
          selectedPage: selectedPage,
          onTap: () => selectedPage.value = NavigationPage.profile,
        ),
      ],
    );
  }
}

class NavigationItem extends HookWidget {
  final String title;
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final NavigationPage page;
  final ValueNotifier<NavigationPage> selectedPage;
  final VoidCallback onTap;

  const NavigationItem({
    super.key,
    required this.title,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.page,
    required this.selectedPage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();
    // final isSelected = selectedPage.value == page;
    // TODO: Remove when the app is ready for page selection
    final isSelected = NavigationPage.home == page;

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 200),
      initialValue: isSelected ? 1.0 : 0.0,
    );

    useEffect(() {
      if (isSelected) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
      return null;
    }, [isSelected]);

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        final color = Color.lerp(
          theme.colors.iconColor,
          theme.colors.selectedIconColor,
          animationController.value,
        );

        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(theme.spaces.xs),
          overlayColor: WidgetStateProperty.all(
              theme.colors.selectedIconColor.withValues(alpha: 0.1)),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: theme.spaces.xs,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: theme.spaces.xxs,
              children: [
                Transform.scale(
                  scale: 1.0 + (animationController.value * 0.1),
                  child: Icon(
                    isSelected ? selectedIcon : unselectedIcon,
                    color: color,
                    size: theme.spaces.xl,
                  ),
                ),
                Text(
                  title,
                  style: theme.text.common.bodyMedium.copyWith(color: color),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
