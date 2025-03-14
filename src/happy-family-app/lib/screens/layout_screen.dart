import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/providers/home_screen_provider.dart';
import 'package:fluttertest/screens/login_screen.dart';
import 'package:fluttertest/widgets/happy_family_logo_widget.dart';
import 'about_screen.dart';
import 'chat_list_screen.dart';
import 'documents_screen.dart';
import 'events_screen.dart';
import 'home_page_screen.dart';
import 'family_info_screen.dart';
import 'poll_list_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'support_screen.dart';
import '../utils/screen_list.dart';

class LayoutScreen extends ConsumerStatefulWidget {
  const LayoutScreen({super.key});

  @override
  ConsumerState<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends ConsumerState<LayoutScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomePageScreen(),
    FamilyInfoScreen(),
    ChatListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onDrawerItemTapped(ScreenList screen) {
    Navigator.pop(context);

    if (screen == ScreenList.logout) {
      _showLogoutConfirmationDialog();
      return;
    }

    Widget? selectedScreen;
    switch (screen) {
      case ScreenList.profile:
        selectedScreen = ProfileScreen();
        break;
      case ScreenList.documents:
        selectedScreen = DocumentsScreen();
        break;
      case ScreenList.events:
        selectedScreen = EventsScreen();
        break;
      case ScreenList.support:
        selectedScreen = SupportScreen();
        break;
      case ScreenList.about:
        selectedScreen = AboutScreen();
        break;
      case ScreenList.settings:
        selectedScreen = SettingsScreen();
        break;
      case ScreenList.polls:
        selectedScreen = PollListScreen();
        break;
      default:
        selectedScreen = HomePageScreen();
    }

    // if (selectedScreen != null) {

    // }
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => selectedScreen!));
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _logoutUser();
              },
            ),
          ],
        );
      },
    );
  }

  void _logoutUser() {
    if (kDebugMode) {
      print("User logged out");
    }

    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProviderAsyncValue = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: HappyFamilyLogoAppBar(),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => print('Notifications icon tapped'),
          ),
        ],
      ),
      drawer: Drawer(
        child: homeProviderAsyncValue.when(
          data: (user) => _buildDrawerContent(user),
          error:
              (error, stackTrace) =>
                  const Center(child: Text('Error loading user data')),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Family'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        ],
      ),
    );
  }

  Widget _buildDrawerContent(user) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text('${user.firstName} ${user.lastName}'),
          accountEmail: Text(user.emailAddress),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(user.displayPicture),
            backgroundColor: Theme.of(context).cardColor,
          ),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          onDetailsPressed: () => _onDrawerItemTapped(ScreenList.profile),
        ),
        _buildMenuListTiles(),
      ],
    );
  }

  Widget _buildMenuListTiles() {
    return Column(
      children: <Widget>[
        _getMenuItemTile('Profile', Icons.account_circle, ScreenList.profile),
        _getMenuItemTile('Documents', Icons.book, ScreenList.documents),
        _getMenuItemTile('Events', Icons.event, ScreenList.events),
        _getMenuItemTile('Polls', Icons.poll, ScreenList.polls),
        _getMenuItemTile('Support', Icons.support, ScreenList.support),
        _getMenuItemTile('Settings', Icons.settings, ScreenList.settings),
        _getMenuItemTile('About', Icons.info, ScreenList.about),
        _getMenuItemTile('Logout', Icons.logout, ScreenList.logout),
      ],
    );
  }

  Widget _getMenuItemTile(String title, IconData icon, ScreenList screen) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      onTap: () => _onDrawerItemTapped(screen),
    );
  }
}
