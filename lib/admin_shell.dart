import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'core/app_colors.dart';
import 'core/widgets/patto_wordmark.dart';
import 'core/widgets/text/app_text.dart';
import 'features/profile/controllers/profile_controller.dart';


// ----- Sidebar model -----
class _NavItem {
  final IconData icon;
  final String label;
  final int? badge;
  const _NavItem(this.icon, this.label, {this.badge});
}

class _NavSection {
  final String title;
  final List<_NavItem> items;
  const _NavSection(this.title, this.items);
}

// Flattened order MUST match the branch order in app_router.dart.
const List<_NavSection> _sections = [
  _NavSection('OVERVIEW', [
    _NavItem(Icons.grid_view_rounded, 'Overview'),
    _NavItem(Icons.people_alt_outlined, 'Couples'),
    _NavItem(Icons.person_outline, 'Users'),
  ]),
  _NavSection('REVENUE', [
    _NavItem(Icons.credit_card_outlined, 'Subscriptions'),
    _NavItem(Icons.link_rounded, 'Referrals'),
  ]),
  _NavSection('PRODUCT', [
    _NavItem(Icons.local_fire_department_outlined, 'Engagement'),
    _NavItem(Icons.access_time_rounded, 'Session Time'),
    _NavItem(Icons.menu_book_outlined, 'Topics & Pacts'),
    _NavItem(Icons.memory_outlined, 'AI & API Costs'),
  ]),
  _NavSection('OPERATIONS', [
    _NavItem(Icons.headset_mic_outlined, 'Support', badge: 4),
    _NavItem(Icons.lock_outline, 'GDPR & Data', badge: 2),
  ]),
];

const List<String> _titles = [
  'Overview',
  'Couples',
  'Users',
  'Subscriptions',
  'Referrals',
  'Engagement',
  'Session Time',
  'Topics & Pacts',
  'AI & API Costs',
  'Support',
  'GDPR & Data',
];

// Titles the mockups render in an italic serif.
const Set<int> _serifTitleIndexes = {4, 5, 6, 7, 8, 9};

class AdminShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AdminShell({super.key, required this.navigationShell});

  static const double mobileBreakpoint = 900;

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    final isMobile = MediaQuery.of(context).size.width < mobileBreakpoint;
    final index = navigationShell.currentIndex;

    if (isMobile) {
      return Scaffold(
        backgroundColor: AppColors.shellBg,
        drawer: Drawer(
          width: 288,
          backgroundColor: AppColors.sidebar,
          child: SafeArea(
            child: _Sidebar(navigationShell: navigationShell, isDrawer: true),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              _TopBar(index: index, isMobile: true),
              Expanded(child: navigationShell),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.shellBg,
      body: Row(
        children: [
          _Sidebar(navigationShell: navigationShell),
          Expanded(
            child: Column(
              children: [
                _TopBar(index: index),
                Expanded(child: navigationShell),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final bool isDrawer;
  const _Sidebar({required this.navigationShell, this.isDrawer = false});

  @override
  Widget build(BuildContext context) {
    final current = navigationShell.currentIndex;

    void go(int index) {
      navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
      if (isDrawer) Navigator.of(context).maybePop();
    }

    // Build sections while tracking the flattened branch index.
    final children = <Widget>[];
    var flatIndex = 0;
    for (final section in _sections) {
      children.add(Padding(
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 10),
        child: AppText(
          data: section.title,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.sidebarSection,
          letterSpacing: 1.2,
        ),
      ));
      for (final item in section.items) {
        final i = flatIndex;
        children.add(_SidebarItem(
          icon: item.icon,
          label: item.label,
          badge: item.badge,
          isSelected: current == i,
          onTap: () => go(i),
        ));
        flatIndex++;
      }
    }

    return Container(
      width: isDrawer ? null : 280,
      color: AppColors.sidebar,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 28, 24, 4),
            child: PattoWordmark(fontSize: 34, color: Colors.white, italic: true),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 8),
            child: AppText(
              data: 'Admin Dashboard',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.sidebarSection,
              letterSpacing: 1.4,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0x22FFFFFF)),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 16, 24, 4),
            child: AppText(
              data: 'Logged in as',
              fontSize: 13,
              color: AppColors.sidebarLabel,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 20),
            child: AppText(
              data: 'Roberto Massa',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int? badge;
  final bool isSelected;
  final VoidCallback onTap;
  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.badge,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fg = isSelected ? AppColors.sidebarSelectedText : AppColors.sidebarLabel;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.sidebarSelected : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 21, color: fg),
            const SizedBox(width: 14),
            Expanded(
              child: AppText(
                data: label,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: fg,
              ),
            ),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.18)
                      : Colors.white.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AppText(
                  data: '$badge',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final int index;
  final bool isMobile;
  const _TopBar({required this.index, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();
    final title = _titles[index];
    final serif = _serifTitleIndexes.contains(index);

    final avatar = Obx(
      () => CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.sidebar,
        backgroundImage:
            c.avatarUrl.value.isEmpty ? null : NetworkImage(c.avatarUrl.value),
        child: c.avatarUrl.value.isEmpty
            ? Text(
                c.initials,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700),
              )
            : null,
      ),
    );

    final titleWidget = Text(
      title,
      style: TextStyle(
        fontSize: isMobile ? 24 : 34,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        fontFamily: serif ? 'Georgia' : null,
        fontStyle: serif ? FontStyle.italic : FontStyle.normal,
      ),
    );

    if (isMobile) {
      return Container(
        height: 68,
        color: AppColors.shellBg,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.menu, color: AppColors.textPrimary),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            ),
            Expanded(child: titleWidget),
            InkWell(
              onTap: c.openMenu,
              customBorder: const CircleBorder(),
              child: Padding(padding: const EdgeInsets.all(4), child: avatar),
            ),
            const SizedBox(width: 4),
          ],
        ),
      );
    }

    return Container(
      height: 100,
      color: AppColors.shellBg,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          Expanded(child: titleWidget),
          // Search box
          Container(
            width: 360,
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColors.border),
            ),
            child: const AppText(
              data: 'Search users, couples, tickets…',
              fontSize: 15,
              color: Color(0xFFA79AA0),
            ),
          ),
          const SizedBox(width: 16),
          // Export CSV (outlined)
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(28),
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.border),
              ),
              child: const AppText(
                data: 'Export CSV',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 16),
          InkWell(
            onTap: c.openMenu,
            customBorder: const CircleBorder(),
            child: avatar,
          ),
        ],
      ),
    );
  }
}
