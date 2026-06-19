import 'package:flutter/material.dart';
import 'utils.dart';

void main() {
  runApp(const MyApp());
}

enum ProfileTab { gallery, collection }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 1;

  ProfileTab _selectedTab = ProfileTab.gallery;

  final List<String> images = List.generate(
    9,
    (index) => "assets/images/$index.jpg",
  );

  static const String userName = "username";
  static const String profession = "job";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: [
          /// Cover Image
          Positioned(
            top: -60,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: OvalBottomClipper(),
              child: Image.asset("assets/images/cover.jpg", fit: BoxFit.cover),
            ),
          ),

          /// Top Bar
          Positioned(
            top: 30,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 35,
                  ),
                ),

                Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),

                    Positioned(
                      bottom: 10,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 4,
                          backgroundColor: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Profile Picture
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: CircleAvatar(
              radius: 56,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: const AssetImage(
                  "assets/images/profil_pic.png",
                ),
              ),
            ),
          ),

          /// Profile Information
          Positioned(
            top: 225,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Text(
                  userName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),

                const Text(
                  profession,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),

                SizedBox(
                  height: 80,
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      StatColumn(total: "21", statName: "Projects"),
                      StatColumn(total: "2.7K", statName: "Followers"),
                      StatColumn(total: "10", statName: "Following"),
                    ],
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 110,
                      vertical: 16,
                    ),
                    child: Text(
                      "Follow",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTab(
                      title: "Gallery",
                      selected: _selectedTab == ProfileTab.gallery,
                      onTap: () {
                        setState(() {
                          _selectedTab = ProfileTab.gallery;
                        });
                      },
                    ),

                    _buildTab(
                      title: "Collection",
                      selected: _selectedTab == ProfileTab.collection,
                      onTap: () {
                        setState(() {
                          _selectedTab = ProfileTab.collection;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Gallery
          Positioned(
            top: 465,
            bottom: 0,
            left: 25,
            right: 25,
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: GridView.builder(
                itemCount: images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(images[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,

        showSelectedLabels: false,
        showUnselectedLabels: false,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.computer),
            label: "Pictures",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: selected ? Colors.deepPurple : Colors.grey,
              ),
            ),
            const SizedBox(height: 6),
            CircleAvatar(
              radius: 3,
              backgroundColor: selected
                  ? Colors.deepPurple
                  : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

class StatColumn extends StatelessWidget {
  final String total;
  final String statName;

  const StatColumn({super.key, required this.total, required this.statName});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          total,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),

        const SizedBox(height: 4),

        Text(
          statName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}