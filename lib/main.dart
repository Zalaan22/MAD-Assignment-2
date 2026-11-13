import 'package:flutter/material.dart';

// ==========================================
// 1. MAIN ENTRY POINT
// ==========================================
void main() {
  // Launch the Flutter application
  runApp(const MovieHubApp());
}

// ==========================================
// 2. ROOT APPLICATION WIDGET
// ==========================================
// StatelessWidget: Configures MaterialApp, theme, and sets the root starting screen.
class MovieHubApp extends StatelessWidget {
  const MovieHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Return root MaterialApp configuration
    return MaterialApp(
      title: 'Movie Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ==========================================
// 3. SPLASH SCREEN
// ==========================================
// StatefulWidget: Displays the animated splash branding and redirects to the home screen.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // State variable tracking opacity for the fade-in animation
  double _opacity = 0.0;

  @override
  void initState() {
    // initState: Lifecycle method called once when the widget is first inserted into the tree
    super.initState();

    // Future.delayed: Waits 100 milliseconds before triggering the fade-in effect
    Future.delayed(const Duration(milliseconds: 100), () {
      // mounted check: Ensures the widget is still active in the tree before updating state
      if (mounted) {
        // setState: Notifies Flutter that internal state changed, triggering a UI rebuild
        setState(() {
          _opacity = 1.0;
        });
      }
    });

    // Future.delayed: Waits 3 seconds before automatically navigating to the HomeScreen
    Future.delayed(const Duration(seconds: 3), () {
      // mounted check: Verifies the widget is still mounted before attempting navigation
      if (mounted) {
        // Navigator.pushReplacement: Replaces SplashScreen with HomeScreen in the route stack
        // so pressing the back button will exit the app rather than returning to splash
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the visual background and structural foundation of the screen
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // Column aligns the logo, title, and tagline vertically
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AnimatedOpacity: Implicitly animates child opacity changes over 2 seconds
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 2),
              // Emoji inside Text widget for branding visual without external images
              child: const Text(
                '🎬',
                style: TextStyle(fontSize: 80),
              ),
            ),
            // SizedBox provides vertical spacing between logo and title
            const SizedBox(height: 16),
            // App Title
            const Text(
              'Movie Hub',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                letterSpacing: 0.5,
              ),
            ),
            // SizedBox provides vertical spacing between title and tagline
            const SizedBox(height: 8),
            // App Subtitle / Tagline
            const Text(
              'Your world of movies, all in one place',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 4. HOME SCREEN
// ==========================================
// StatelessWidget: Main hub of the app displaying navigation cards and drawer menu.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the main screen layout structure
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Hub'),
      ),
      // Drawer menu for switching between app screens
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // DrawerHeader displays app branding at the top of the drawer menu
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Emoji icon in drawer header
                  Text('🎬', style: TextStyle(fontSize: 48)),
                  SizedBox(height: 8),
                  // App title in drawer header
                  Text(
                    'Movie Hub',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            // Navigation item: Home Screen
            ListTile(
              leading: const Icon(Icons.home, color: Colors.deepPurple),
              title: const Text('Home'),
              onTap: () {
                // Close the drawer menu
                Navigator.pop(context);
                // Replace current route with HomeScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            // Navigation item: Movie List Screen
            ListTile(
              leading: const Icon(Icons.movie, color: Colors.deepPurple),
              title: const Text('Movie List'),
              onTap: () {
                // Close the drawer menu
                Navigator.pop(context);
                // Replace current route with ListScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ListScreen()),
                );
              },
            ),
            // Navigation item: About Screen
            ListTile(
              leading: const Icon(Icons.info, color: Colors.deepPurple),
              title: const Text('About'),
              onTap: () {
                // Close the drawer menu
                Navigator.pop(context);
                // Replace current route with AboutScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
          ],
        ),
      ),
      // SingleChildScrollView allows the content to scroll safely on smaller screens
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header emoji visual
              const Text(
                '🎬',
                style: TextStyle(fontSize: 64),
              ),
              const SizedBox(height: 12),
              // Header title
              const Text(
                'Welcome to Movie Hub',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 8),
              // Header subtitle description
              const Text(
                'Browse top movies and explore genres',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),

              // Card 1: Navigates to Movie List screen
              InkWell(
                onTap: () {
                  // Push ListScreen onto navigation stack
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListScreen()),
                  );
                },
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Row(
                      children: [
                        // Movie list icon
                        Icon(Icons.movie, color: Colors.deepPurple, size: 30),
                        SizedBox(width: 16),
                        // Movie list card label
                        Text(
                          'Movie List',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Spacer pushes the arrow icon to the right edge
                        Spacer(),
                        // Trailing chevron arrow icon
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Card 2: Navigates to About screen
              InkWell(
                onTap: () {
                  // Push AboutScreen onto navigation stack
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutScreen()),
                  );
                },
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Row(
                      children: [
                        // About icon
                        Icon(Icons.info, color: Colors.deepPurple, size: 30),
                        SizedBox(width: 16),
                        // About card label
                        Text(
                          'About',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Spacer pushes the arrow icon to the right edge
                        Spacer(),
                        // Trailing chevron arrow icon
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 5. LIST SCREEN
// ==========================================
// Constant list of 10 movie titles displayed in the ListView.builder
const List<String> movies = [
  'Inception (2010) — Sci-Fi',
  'Interstellar (2014) — Sci-Fi',
  'The Dark Knight (2008) — Action',
  'Titanic (1997) — Romance',
  'Avatar (2009) — Adventure',
  'Avengers: Endgame (2019) — Action',
  'Forrest Gump (1994) — Drama',
  'The Matrix (1999) — Sci-Fi',
  'Gladiator (2000) — Action',
  'Jurassic Park (1993) — Adventure',
];

// StatelessWidget: Displays a list of items with no dynamic internal state.
class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the visual screen structure
    return Scaffold(
      // Drawer menu for switching between app screens
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // DrawerHeader displays app branding at the top of the drawer menu
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Emoji icon in drawer header
                  Text('🎬', style: TextStyle(fontSize: 48)),
                  SizedBox(height: 8),
                  // App title in drawer header
                  Text(
                    'Movie Hub',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            // Navigation item: Home Screen
            ListTile(
              leading: const Icon(Icons.home, color: Colors.deepPurple),
              title: const Text('Home'),
              onTap: () {
                // Close the drawer menu
                Navigator.pop(context);
                // Replace current route with HomeScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            // Navigation item: Movie List Screen
            ListTile(
              leading: const Icon(Icons.movie, color: Colors.deepPurple),
              title: const Text('Movie List'),
              onTap: () {
                // Close the drawer menu
                Navigator.pop(context);
                // Replace current route with ListScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ListScreen()),
                );
              },
            ),
            // Navigation item: About Screen
            ListTile(
              leading: const Icon(Icons.info, color: Colors.deepPurple),
              title: const Text('About'),
              onTap: () {
                // Close the drawer menu
                Navigator.pop(context);
                // Replace current route with AboutScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
          ],
        ),
      ),
      // CustomScrollView: Enables custom scrolling effects by composing multiple sliver widgets
      body: CustomScrollView(
        // slivers: Collection of scrollable sliver portions within the scroll view
        slivers: [
          // SliverAppBar: Collapsible App Bar that shrinks and stays pinned at the top
          const SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            // FlexibleSpaceBar: Expandable space that holds the title and animates during scroll
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Movie Hub'),
              centerTitle: true,
            ),
          ),
          // SliverList: Sliver that renders items linearly along the scroll direction
          SliverList(
            // SliverChildBuilderDelegate: Lazily constructs list children as they scroll into view
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // Card represents a single movie entry styled like BijliBuddy SlabRates
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Row(
                      children: [
                        // Movie icon for the card
                        const Icon(
                          Icons.movie,
                          color: Colors.deepPurple,
                          size: 28,
                        ),
                        const SizedBox(width: 14),
                        // Expanded allows the movie title text to take remaining horizontal width
                        Expanded(
                          child: Text(
                            movies[index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              // childCount: Total number of items to supply to the delegate
              childCount: movies.length,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 6. ABOUT SCREEN
// ==========================================
// StatelessWidget: Displays information about the app and author with no dynamic internal state.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the visual screen structure
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      // Drawer menu for switching between app screens
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // DrawerHeader displays app branding at the top of the drawer menu
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Emoji icon in drawer header
                  Text('🎬', style: TextStyle(fontSize: 48)),
                  SizedBox(height: 8),
                  // App title in drawer header
                  Text(
                    'Movie Hub',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            // Navigation item: Home Screen
            ListTile(
              leading: const Icon(Icons.home, color: Colors.deepPurple),
              title: const Text('Home'),
              onTap: () {
                // Close the drawer menu
                Navigator.pop(context);
                // Replace current route with HomeScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            // Navigation item: Movie List Screen
            ListTile(
              leading: const Icon(Icons.movie, color: Colors.deepPurple),
              title: const Text('Movie List'),
              onTap: () {
                // Close the drawer menu
                Navigator.pop(context);
                // Replace current route with ListScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ListScreen()),
                );
              },
            ),
            // Navigation item: About Screen
            ListTile(
              leading: const Icon(Icons.info, color: Colors.deepPurple),
              title: const Text('About'),
              onTap: () {
                // Close the drawer menu
                Navigator.pop(context);
                // Replace current route with AboutScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
          ],
        ),
      ),
      // Padding provides screen boundary spacing around the content column
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Screen title
            const Text(
              'About Movie Hub',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            // Description subtitle
            const Text(
              'Movie Hub lets you browse top movies and explore popular genres.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),

            // Expanded: Allocates the remaining vertical space to the GridView
            Expanded(
              // GridView.count: Creates a 2D scrollable grid with a fixed cross-axis count
              child: GridView.count(
                // crossAxisCount: Sets the grid to exactly 2 columns
                crossAxisCount: 2,
                // crossAxisSpacing: Horizontal spacing between columns
                crossAxisSpacing: 12,
                // mainAxisSpacing: Vertical spacing between rows
                mainAxisSpacing: 12,
                // childAspectRatio: Aspect ratio (width / height) for each grid card
                childAspectRatio: 1.2,
                children: [
                  // Genre Card 1: Action
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('💥', style: TextStyle(fontSize: 40)),
                        SizedBox(height: 8),
                        Text(
                          'Action',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Genre Card 2: Comedy
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('😂', style: TextStyle(fontSize: 40)),
                        SizedBox(height: 8),
                        Text(
                          'Comedy',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Genre Card 3: Horror
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('👻', style: TextStyle(fontSize: 40)),
                        SizedBox(height: 8),
                        Text(
                          'Horror',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Genre Card 4: Romance
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('❤️', style: TextStyle(fontSize: 40)),
                        SizedBox(height: 8),
                        Text(
                          'Romance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Genre Card 5: Sci-Fi
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🚀', style: TextStyle(fontSize: 40)),
                        SizedBox(height: 8),
                        Text(
                          'Sci-Fi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Genre Card 6: Animation
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🎨', style: TextStyle(fontSize: 40)),
                        SizedBox(height: 8),
                        Text(
                          'Animation',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Divider line separating the grid from author credentials
            const Divider(indent: 40, endIndent: 40),
            const SizedBox(height: 12),
            // Author credit line
            const Text(
              'Developed by [Your Name]',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
