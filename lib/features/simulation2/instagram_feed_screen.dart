// lib/features/simulation2/
// ├── instagram_feed_screen.dart        ← main Instagram UI
// ├── scam_shop_screen.dart             ← fake shopping site
// ├── otp_chat_screen.dart              ← AI scammer chat
// ├── sim2_debrief_screen.dart          ← "you were scammed" result
// ├── sim2_intro_screen.dart            ← entry point
// └── quiz/
// ├── sim2_questions.dart           ← already exists, we'll fill it
// ├── sim2_quiz_screen.dart         ← already exists
// └── sim2_result_screen.dart       ← already exists, we'll fill it

import 'package:flutter/material.dart';

class InstagramFeedScreen extends StatefulWidget {
  @override
  State<InstagramFeedScreen> createState() => _InstagramFeedScreenState();
}

class _InstagramFeedScreenState extends State<InstagramFeedScreen> {
  // Which posts have been "liked"
  final Set<int> _liked = {};
  bool _scamAdTapped = false;

  final List<_FeedPost> _posts = [
    _FeedPost(
      username: 'priya.sharma',
      avatarLetter: 'P',
      avatarColor: Color(0xFFE91E63),
      imagePath: 'assets/images/lonavla.jpg',
      caption: 'Beautiful morning at Lonavala! ☀️ #travel #Maharashtra',
      likes: 342,
      time: '2 hours ago',
      isScam: false,
      isAd: false,
    ),
    _FeedPost(
      username: 'rahul.foodie',
      avatarLetter: 'R',
      avatarColor: Color(0xFF4CAF50),
      imagePath: 'assets/images/pav-bhaji.jpg',
      caption: 'Homemade pav bhaji 😍 Recipe in bio! #food #Mumbai',
      likes: 891,
      time: '4 hours ago',
      isScam: false,
      isAd: false,
    ),
    _FeedPost(
      username: 'flipkart_deals_99',
      avatarLetter: 'F',
      avatarColor: Color(0xFF2196F3),
      imagePath: 'assets/images/iphone.jpg',
      caption:
      '🔥 MEGA SALE! iPhone 15 for ₹4,999 only! Limited stock! '
          'Click link in bio NOW! Offer expires in 1 hour! ⚡ #sale #deals',
      likes: 12,
      time: 'Sponsored',
      isScam: true,
      isAd: true,
    ),
    _FeedPost(
      username: 'ananya.art',
      avatarLetter: 'A',
      avatarColor: Color(0xFF9C27B0),
      imagePath: 'assets/images/draw.jpg',
      caption: 'My latest watercolour piece 🎨 #art #creative',
      likes: 567,
      time: '1 day ago',
      isScam: false,
      isAd: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildInstagramTopBar(),
            _buildStoriesRow(),
            Expanded(
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, i) => _buildPost(context, i),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildInstagramBottomBar(),
    );
  }

  Widget _buildInstagramTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Instagram',
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 26,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
            ),
          ),
          Row(
            children: [
              Icon(Icons.favorite_border, size: 26),
              const SizedBox(width: 16),
              Icon(Icons.send_outlined, size: 26),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStoriesRow() {
    final stories = [
      ('Your Story', 'Y', Colors.grey),
      ('priya.s', 'P', Color(0xFFE91E63)),
      ('rahul.f', 'R', Color(0xFF4CAF50)),
      ('ananya.a', 'A', Color(0xFF9C27B0)),
      ('mohit.k', 'M', Color(0xFFFF9800)),
    ];
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: stories.length,
        itemBuilder: (_, i) {
          final s = stories[i];
          return Padding(
            padding: const EdgeInsets.only(right: 14, top: 8),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: i == 0
                        ? null
                        : const LinearGradient(colors: [
                      Color(0xFFf09433),
                      Color(0xFFe6683c),
                      Color(0xFFdc2743),
                      Color(0xFFcc2366),
                      Color(0xFFbc1888),
                    ]),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: s.$3,
                    child: i == 0
                        ? const Icon(Icons.add, color: Colors.white)
                        : Text(s.$2,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 4),
                Text(s.$1,
                    style: const TextStyle(fontSize: 11),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPost(BuildContext context, int i) {
    final post = _posts[i];
    final isLiked = _liked.contains(i);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: post.isScam
                      ? Border.all(color: Colors.red.shade400, width: 2)
                      : null,
                ),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: post.avatarColor,
                  child: Text(post.avatarLetter,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.username,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    if (post.isAd)
                      Text('Sponsored',
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              Icon(Icons.more_horiz, color: Colors.grey.shade700),
            ],
          ),
        ),

        // Image area
        GestureDetector(
          onTap: post.isScam ? () => _onScamAdTapped(context) : null,
          child: Stack(
            children: [
              // 🔹 Real Image (background)
              SizedBox(
                width: double.infinity,
                height: 300,
                child: Image.asset(
                  post.imagePath,
                  fit: BoxFit.cover,
                ),
              ),

              // 🔴 SCAM OVERLAY (same as before)
              if (post.isScam)
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.red.shade600,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '🔥 iPhone 15 @ ₹4,999\nOnly 3 left! TAP NOW',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

              // 🟠 AD badge (top right)
              if (post.isScam)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade700,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'AD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Action row
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => isLiked
                    ? _liked.remove(i)
                    : _liked.add(i)),
                child: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.black,
                  size: 26,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.chat_bubble_outline, size: 24),
              const SizedBox(width: 16),
              Icon(Icons.send_outlined, size: 24),
              const Spacer(),
              Icon(Icons.bookmark_border, size: 24),
            ],
          ),
        ),

        // Likes
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '${post.likes + (isLiked ? 1 : 0)} likes',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),

        // Caption
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              children: [
                TextSpan(
                    text: post.username + ' ',
                    style:
                    const TextStyle(fontWeight: FontWeight.w600)),
                TextSpan(text: post.caption),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Text(post.time,
              style: TextStyle(
                  color: Colors.grey.shade500, fontSize: 11)),
        ),

        // Scam tap prompt
        if (post.isScam)
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: GestureDetector(
              onTap: () => _onScamAdTapped(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Shop Now →',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

        const Divider(height: 1),
      ],
    );
  }

  void _onScamAdTapped(BuildContext context) {
    if (_scamAdTapped) return;
    _scamAdTapped = true;
    // Show a red flag hint before navigating
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Colors.orange.shade700),
            const SizedBox(width: 8),
            const Text('Did you notice?'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('🚩 This account is brand new (only 12 likes)'),
            SizedBox(height: 8),
            Text('🚩 Username looks like "flipkart" but has "_99"'),
            SizedBox(height: 8),
            Text('🚩 "Only 3 left!" creates fake urgency'),
            SizedBox(height: 8),
            Text('🚩 account is not verified (no blue tick)'),
            SizedBox(height: 12),
            Text(
              'Let\'s see where this link takes you...',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sim2-shop');
            },
            child: const Text('Continue →'),
          ),
        ],
      ),
    );
    //_scamAdTapped = false;
  }

  Widget _buildInstagramBottomBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: ''),
      ],
    );
  }
}

class _FeedPost {
  final String username, avatarLetter, caption, time;
  final Color avatarColor;
  final String imagePath;
  final int likes;
  final bool isScam, isAd;

  const _FeedPost({
    required this.username,
    required this.avatarLetter,
    required this.avatarColor,
    required this.imagePath,
    required this.caption,
    required this.likes,
    required this.time,
    required this.isScam,
    required this.isAd,
  });
}
