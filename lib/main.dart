import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/order_screen.dart';
import 'screens/user_profile_screen.dart';
import 'screens/product_detail_screen.dart';
import 'widgets/custom_bottom_nav_bar.dart';
import 'widgets/side_drawer.dart';
import 'providers/user_provider.dart';
import 'providers/product_provider.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SkillConnect',
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                builder: (context) => const SplashScreen(),
              );
            case '/login':
              return MaterialPageRoute(
                builder: (context) => LoginScreen(),
              );
            case '/signup':
              return MaterialPageRoute(
                builder: (context) => const SignupScreen(),
              );
            case '/main':
              return MaterialPageRoute(
                builder: (context) => const MainScreen(),
              );
            case '/profile':
              return MaterialPageRoute(
                builder: (context) => const UserProfileScreen(),
              );
            case '/product-detail':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) => ServiceDetailsScreen(
                  title: args['title'],
                  provider: args['provider'],
                  imageUrl: args['imageUrl'],
                  price: args['price'],
                  rating: args['rating'],
                  location: args['location'],
                  phone: args['phone'],
                  experience: args['experience'],
                  availability: args['availability'],
                ),
              );
            default:
              return MaterialPageRoute(
                builder: (context) => const Scaffold(
                  body: Center(
                    child: Text('Route not found!'),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const OrderScreen(),
    const UserProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
