import 'dart:io';
import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:recycleapp/models/nav_item.dart' show TabItem;

class MainScaffold extends StatefulWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int currentPage = 0;
  bool isNavBarVisible = true;

  final List<TabItem> tabs = const [
    TabItem(icon: Icons.home, route: '/home', title: 'Acceuil'),
    TabItem(icon: Icons.search, route: '/search', title: 'Ramassage'),
    TabItem(icon: Icons.camera_alt, route: '/camera-view', title: 'Signaler'),
    TabItem(
      icon: Icons.my_library_books_outlined,
      route: '/learn',
      title: 'Actualités',
    ),
    TabItem(
      icon: Icons.manage_accounts_sharp,
      route: '/profile-view',
      title: 'Profile',
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final location = GoRouterState.of(context).uri.toString();
    final index = tabs.indexWhere((tab) => location.startsWith(tab.route));
    if (index != -1 && currentPage != index) {
      setState(() => currentPage = index);
    }
  }

  void _handleUserScroll(UserScrollNotification notification) {
    final direction = notification.direction;
    if (direction == ScrollDirection.reverse && isNavBarVisible) {
      setState(() => isNavBarVisible = false);
    } else if (direction == ScrollDirection.forward && !isNavBarVisible) {
      setState(() => isNavBarVisible = true);
    }
  }

  Future<bool> _onWillPop() async {
    final currentLocation = GoRouterState.of(context).uri.toString();

    if (currentLocation != '/home') {
      final homeIndex = tabs.indexWhere((tab) => tab.route == '/home');
      setState(() => currentPage = homeIndex);
      context.go('/home');
      return false;
    }

    // Already on /home → show exit dialog
    final shouldExit = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Quitter l'application"),
            content: Text("Voulez-vous vraiment quitter ?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("Annuler"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Quitter"),
              ),
            ],
          ),
    );

    if (shouldExit == true) {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            _handleUserScroll(notification);
            return false;
          },
          child: widget.child,
        ),
        bottomNavigationBar: AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          offset: isNavBarVisible ? Offset.zero : const Offset(0, 1.5),
          child: CircleBottomNavigation(
            hasElevationShadows: true,
            initialSelection: currentPage,
            barHeight: 60,
            circleSize: 60,
            shadowAllowance: 20,
            circleColor: Colors.green,
            textColor: Colors.green.shade700,
            activeIconColor: Colors.white,
            inactiveIconColor: Colors.green.shade300,
            tabs:
                tabs
                    .map((tab) => TabData(icon: tab.icon, title: tab.title))
                    .toList(),
            onTabChangedListener: (index) {
              if (tabs[index].route == '/camera-view') {
                context.push('/camera-view');
                return;
              }
              if (index != currentPage) {
                setState(() => currentPage = index);
                context.go(tabs[index].route);
              }
            },
          ),
        ),
      ),
    );
  }
}
