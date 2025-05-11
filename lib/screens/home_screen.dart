import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  int _selectedCategory = 0;

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
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: NestedScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 340,
              floating: true,
              pinned: true,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.menu_rounded, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
              actions: [
                IconButton(
                  icon: Badge(
                    backgroundColor: Colors.red.shade400,
                    smallSize: 8,
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
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.9),
                        Theme.of(context).primaryColor.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Welcome section
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 2,
                                  ),
                                ),
                                child: const CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Welcome back',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Alex Johnson',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          // Search bar
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.search_rounded,
                                    color: Colors.grey.shade500),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText:
                                          'Search for artisans, services...',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(Icons.tune_rounded,
                                    color: Colors.grey.shade500),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Featured artisans section
                          const Text(
                            'Featured Artisans',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 120,
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
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Categories tabs
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              width: 3,
                              color: Theme.of(context).primaryColor,
                            ),
                            insets: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          labelColor: Theme.of(context).primaryColor,
                          unselectedLabelColor: Colors.grey.shade600,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                          tabs: _categories
                              .map((category) => Tab(text: category))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Popular services title
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, bottom: 8),
                          child: Text(
                            'Popular Services',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildServicesGrid() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75, // Adjusted from 0.9 to give more height
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 10,
        itemBuilder: (context, index) => _ServiceCard(
          title: [
            'Homemade Meals',
            'Handmade Jewelry',
            'Home Cleaning',
            'Math Tutoring',
            'Sewing',
            'Baking',
            'Art Classes',
            'Yoga',
            'Pet Care',
            'Gardening'
          ][index],
          price: '\$${(index + 1) * 15}',
          rating: (index % 5 + 3).toDouble(),
          imageUrl: 'https://picsum.photos/300/200?random=$index',
          provider: [
            'Maria',
            'Aisha',
            'Fatima',
            'Sophia',
            'Elena',
            'Layla',
            'Nora',
            'Zahra',
            'Maya',
            'Leila'
          ][index],
          location: [
            '2.5 km away',
            '5 km away',
            '1 km away',
            'Online',
            '3 km away',
            '4 km away',
            '2 km away',
            'Online',
            '1.5 km away',
            '3.5 km away'
          ][index],
          phone: '+1 (555) ${1000 + index}${1000 + index}',
          experience: '${index + 2} years experience',
          availability: index % 3 == 0 ? 'Available Today' : 'Available Soon',
        ),
      ),
    );
  }
}

class _FeaturedArtisanCard extends StatelessWidget {
  final String name;
  final String skill;
  final String imageUrl;

  const _FeaturedArtisanCard({
    required this.name,
    required this.skill,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          skill,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
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
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showServiceDetails(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service image with overlays
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    imageUrl,
                    height: 100, // Reduced from 120
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // Rating overlay
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
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Availability badge
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: availability.contains('Today')
                          ? Colors.green.shade600
                          : Colors.orange.shade600,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      availability,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              // Wrap the content in Expanded
              child: Padding(
                padding: const EdgeInsets.all(8), // Reduced from 12
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14, // Reduced from 16
                            ),
                            maxLines: 1, // Limit to 1 line
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          price,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14, // Reduced from 16
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4), // Reduced from 8

                    // Provider, location, and experience info
                    Column(
                      children: [
                        _buildInfoRow(Icons.person_outline, provider),
                        _buildInfoRow(Icons.location_on_outlined, location),
                        _buildInfoRow(Icons.work_outline, experience),
                      ],
                    ),
                    const Spacer(), // Add spacer to push buttons to bottom

                    // Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _showContactDialog(context, phone),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4), // Reduced padding
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.phone_outlined,
                                      size: 14,
                                      color: Theme.of(context).primaryColor),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Contact',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(4), // Reduced padding
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.favorite_border_rounded,
                            size: 16,
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
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.grey,
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
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Contact Artisan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Call or message this artisan directly:'),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  phone,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.message, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Message via app',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement call functionality
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Call Now'),
          ),
        ],
      ),
    );
  }

  void _showServiceDetails(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/product-detail',
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
  }
}

class ServiceDetailsScreen extends StatelessWidget {
  final String title;
  final String provider;
  final String imageUrl;
  final String price;
  final double rating;
  final String location;
  final String phone;
  final String experience;
  final String availability;

  const ServiceDetailsScreen({
    Key? key,
    required this.title,
    required this.provider,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.location,
    required this.phone,
    required this.experience,
    required this.availability,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Implement share functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Implement favorite functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(24)),
              child: Image.network(
                imageUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Service details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Provider and location
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          provider,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          location,
                          style: TextStyle(
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Price and rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Availability badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: availability.contains('Today')
                          ? Colors.green.shade100
                          : Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      availability,
                      style: TextStyle(
                        color: availability.contains('Today')
                            ? Colors.green.shade800
                            : Colors.orange.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description section
                  const Text(
                    'Service Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This is a detailed description of the service being offered. It includes all the important details a customer might need to know before booking.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Contact artisan section
                  const Text(
                    'Contact Artisan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        phone,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Implement call functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Call Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
