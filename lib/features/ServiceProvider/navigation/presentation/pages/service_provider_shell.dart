import 'package:expertisemarket/features/ServiceProvider/chats/conversations/presentation/pages/service_provider_conversations_page.dart';
import 'package:expertisemarket/features/ServiceProvider/profile/presentation/pages/service_provider_profile_page.dart';
import 'package:flutter/material.dart';

import '../widgets/service_provider_bottom_navigation_bar.dart';

class ServiceProviderShell extends StatefulWidget {
  const ServiceProviderShell({
    super.key,
    this.initialIndex = 3,
  });

  final int initialIndex;

  @override
  State<ServiceProviderShell> createState() =>
      _ServiceProviderShellState();
}

class _ServiceProviderShellState
    extends State<ServiceProviderShell> {
  late int _currentIndex;

  static const List<Widget> _pages = [
    _ServiceProviderTabPlaceholder(title: 'Home'),
    _ServiceProviderTabPlaceholder(title: 'Requests'),
    _ServiceProviderTabPlaceholder(title: 'Inventory'),
    ServiceProviderConversationsPage(),
    ServiceProviderProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _selectTab(int index) {
    if (index == _currentIndex) {
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: ServiceProviderBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _selectTab,
      ),
    );
  }
}

class _ServiceProviderTabPlaceholder extends StatelessWidget {
  const _ServiceProviderTabPlaceholder({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}