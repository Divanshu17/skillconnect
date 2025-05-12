import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  bool _isScrolled = false;
  final List<String> _categories = [
    'All',
    'Handmade',
    'Cooking',
    'Cleaning',
    'Tutoring',
    'Crafts'
  ];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late AnimationController _welcomeAnimationController;
  late Animation<Offset> _avatarAnimation;
  late Animation<Offset> _textAnimation;
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _isScrolled = _scrollController.offset > 0;
        });
      });
    _welcomeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _avatarAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _welcomeAnimationController,
      curve: Curves.easeOut,
    ));
    _textAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _welcomeAnimationController,
      curve: Curves.easeOut,
    ));
    _welcomeAnimationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _searchController.dispose();
    _welcomeAnimationController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userName = userProvider.user?.name ?? 'Alex Johnson';

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      body: NestedScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 360,
              floating: true,
              pinned: true,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.menu_rounded, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
              actions: [
                IconButton(
                  icon: badges.Badge(
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: Theme.of(context).colorScheme.error,
                    ),
                    badgeContent: const SizedBox(width: 8, height: 8),
                    child: const Icon(Icons.notifications_outlined,
                        color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ],
              backgroundColor: _isScrolled
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SlideTransition(
                                position: _avatarAnimation,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.4),
                                      width: 3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const CircleAvatar(
                                    radius: 26,
                                    backgroundImage: NetworkImage(
                                      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              SlideTransition(
                                position: _textAnimation,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome back',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      userName,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Focus(
                            onFocusChange: (hasFocus) {
                              setState(() {
                                _isSearchFocused = hasFocus;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              transform: Matrix4.identity()
                                ..scale(_isSearchFocused ? 1.02 : 1.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: _isSearchFocused
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        _isSearchFocused ? 0.2 : 0.1),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.search_rounded,
                                      color: Colors.grey.shade600),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      controller: _searchController,
                                      onChanged: _handleSearch,
                                      decoration: InputDecoration(
                                        hintText:
                                            'Search artisans, services...',
                                        border: InputBorder.none,
                                        hintStyle: GoogleFonts.poppins(
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      style: GoogleFonts.poppins(),
                                    ),
                                  ),
                                  Icon(Icons.tune_rounded,
                                      color: Colors.grey.shade600),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Featured Artisans',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 130,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 16),
                              itemBuilder: (context, index) =>
                                  _FeaturedArtisanCard(
                                name: [
                                  'Maria',
                                  'Aisha',
                                  'Fatima',
                                  'Sophia',
                                  'Elena'
                                ][index],
                                skill: [
                                  'Cooking',
                                  'Sewing',
                                  'Cleaning',
                                  'Tutoring',
                                  'Crafts'
                                ][index],
                                imageUrl:
                                    'https://randomuser.me/api/portraits/women/${index + 10}.jpg',
                                animationDelay:
                                    Duration(milliseconds: 200 * index),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          indicator: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).colorScheme.secondary,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey.shade600,
                          labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          unselectedLabelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                          ),
                          tabs: _categories
                              .asMap()
                              .entries
                              .map((entry) => _AnimatedTab(
                                    text: entry.value,
                                    index: entry.key,
                                    controller: _tabController,
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 8),
                          child: Text(
                            'Popular Services',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: List.generate(
              _categories.length, (index) => _buildServicesGrid()),
        ),
      ),
      floatingActionButton: _AnimatedFAB(),
    );
  }

  Widget _buildServicesGrid() {
    final List<Map<String, dynamic>> services = [
      {
        'title': 'Homemade Meals',
        'price': '\$15',
        'rating': 4.5,
        'imageUrl': 'https://picsum.photos/300/200?random=1',
        'provider': 'Maria',
        'location': '2.5 km away',
        'phone': '+1 (555) 1001',
        'experience': '2 years experience',
        'availability': 'Available Today',
      },
      {
        'title': 'Handmade Jewelry',
        'price': '\$25',
        'rating': 4.0,
        'imageUrl': 'https://picsum.photos/300/200?random=2',
        'provider': 'Aisha',
        'location': '5 km away',
        'phone': '+1 (555) 1002',
        'experience': '3 years experience',
        'availability': 'Available Soon',
      },
      {
        'title': 'Home Cleaning',
        'price': '\$35',
        'rating': 4.8,
        'imageUrl': 'https://picsum.photos/300/200?random=3',
        'provider': 'Fatima',
        'location': '1 km away',
        'phone': '+1 (555) 1003',
        'experience': '5 years experience',
        'availability': 'Available Today',
      },
      {
        'title': 'Math Tutoring',
        'price': '\$45',
        'rating': 4.2,
        'imageUrl': 'https://picsum.photos/300/200?random=4',
        'provider': 'Sophia',
        'location': 'Online',
        'phone': '+1 (555) 1004',
        'experience': '4 years experience',
        'availability': 'Available Soon',
      },
      {
        'title': 'Sewing',
        'price': '\$55',
        'rating': 4.6,
        'imageUrl': 'https://picsum.photos/300/200?random=5',
        'provider': 'Elena',
        'location': '3 km away',
        'phone': '+1 (555) 1005',
        'experience': '6 years experience',
        'availability': 'Available Today',
      },
      {
        'title': 'Baking',
        'price': '\$65',
        'rating': 4.7,
        'imageUrl': 'https://picsum.photos/300/200?random=6',
        'provider': 'Layla',
        'location': '4 km away',
        'phone': '+1 (555) 1006',
        'experience': '2 years experience',
        'availability': 'Available Soon',
      },
      {
        'title': 'Art Classes',
        'price': '\$75',
        'rating': 4.9,
        'imageUrl': 'https://picsum.photos/300/200?random=7',
        'provider': 'Nora',
        'location': '2 km away',
        'phone': '+1 (555) 1007',
        'experience': '3 years experience',
        'availability': 'Available Today',
      },
      {
        'title': 'Yoga',
        'price': '\$85',
        'rating': 4.3,
        'imageUrl': 'https://picsum.photos/300/200?random=8',
        'provider': 'Zahra',
        'location': 'Online',
        'phone': '+1 (555) 1008',
        'experience': '5 years experience',
        'availability': 'Available Soon',
      },
      {
        'title': 'Pet Care',
        'price': '\$95',
        'rating': 4.1,
        'imageUrl': 'https://picsum.photos/300/200?random=9',
        'provider': 'Maya',
        'location': '1.5 km away',
        'phone': '+1 (555) 1009',
        'experience': '4 years experience',
        'availability': 'Available Today',
      },
      {
        'title': 'Gardening',
        'price': '\$105',
        'rating': 4.4,
        'imageUrl': 'https://picsum.photos/300/200?random=10',
        'provider': 'Leila',
        'location': '3.5 km away',
        'phone': '+1 (555) 1010',
        'experience': '6 years experience',
        'availability': 'Available Soon',
      },
    ];

    final filteredServices = _searchQuery.isEmpty
        ? services
        : services
            .where((service) =>
                service['title'].toLowerCase().contains(_searchQuery) ||
                service['provider'].toLowerCase().contains(_searchQuery))
            .toList();

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: filteredServices.length,
        itemBuilder: (context, index) {
          final service = filteredServices[index];
          return _ServiceCard(
            title: service['title'],
            price: service['price'],
            rating: service['rating'],
            imageUrl: service['imageUrl'],
            provider: service['provider'],
            location: service['location'],
            phone: service['phone'],
            experience: service['experience'],
            availability: service['availability'],
            animationDelay: Duration(milliseconds: 100 * index),
          );
        },
      ),
    );
  }
}

class _AnimatedTab extends StatefulWidget {
  final String text;
  final int index;
  final TabController controller;

  const _AnimatedTab({
    required this.text,
    required this.index,
    required this.controller,
  });

  @override
  _AnimatedTabState createState() => _AnimatedTabState();
}

class _AnimatedTabState extends State<_AnimatedTab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    widget.controller.addListener(_handleTabChange);
    if (widget.controller.index == widget.index) {
      _animationController.forward();
    }
  }

  void _handleTabChange() {
    if (widget.controller.index == widget.index) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTabChange);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(widget.text),
      ),
    );
  }
}

class _AnimatedFAB extends StatefulWidget {
  @override
  _AnimatedFABState createState() => _AnimatedFABState();
}

class _AnimatedFABState extends State<_AnimatedFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      onTap: () {},
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 6,
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}

class _FeaturedArtisanCard extends StatefulWidget {
  final String name;
  final String skill;
  final String imageUrl;
  final Duration animationDelay;

  const _FeaturedArtisanCard({
    required this.name,
    required this.skill,
    required this.imageUrl,
    required this.animationDelay,
  });

  @override
  _FeaturedArtisanCardState createState() => _FeaturedArtisanCardState();
}

class _FeaturedArtisanCardState extends State<_FeaturedArtisanCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    Future.delayed(widget.animationDelay, () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.imageUrl),
                  radius: 48,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.name,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            Text(
              widget.skill,
              style: GoogleFonts.poppins(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final String price;
  final double rating;
  final String imageUrl;
  final String provider;
  final String location;
  final String phone;
  final String experience;
  final String availability;
  final Duration animationDelay;

  const _ServiceCard({
    required this.title,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.provider,
    required this.location,
    required this.phone,
    required this.experience,
    required this.availability,
    required this.animationDelay,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/service-detail',
          arguments: {
            'title': title,
            'provider': provider,
            'imageUrl': imageUrl,
            'price': price,
            'rating': rating,
            'location': location,
            'phone': phone,
            'experience': experience,
            'availability': availability,
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Theme.of(context).colorScheme.surface],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(-2, -2),
            ),
          ],
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(24)),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                    child: Image.network(
                      imageUrl,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 120,
                          color: Colors.grey[300],
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 120,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          rating.toStringAsFixed(1),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: availability.contains('Today')
                            ? [Colors.green.shade600, Colors.green.shade400]
                            : [Colors.orange.shade600, Colors.orange.shade400],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      availability,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          price,
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        _buildInfoRow(Icons.person_outline, provider),
                        _buildInfoRow(Icons.location_on_outlined, location),
                        _buildInfoRow(Icons.work_outline, experience),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _showContactDialog(context, phone),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context).colorScheme.secondary,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.phone_outlined,
                                      size: 16, color: Colors.white),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Contact',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.favorite_border_rounded,
                            size: 18,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade600),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context, String phone) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text('Contact Artisan', style: GoogleFonts.poppins()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Call or message this artisan directly:',
                style: GoogleFonts.poppins()),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.phone, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  phone,
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.message, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'Message via app',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: GoogleFonts.poppins()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Call Now', style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }
}
