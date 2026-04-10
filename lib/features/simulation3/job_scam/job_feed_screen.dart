import 'package:flutter/material.dart';
//import 'package:safe_digital_learning/core/constants/colors.dart';

class JobFeedScreen extends StatelessWidget {
  const JobFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: const Color(0xFF1A73E8),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: Text(
                  'U',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Unstop',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black54),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFFE0E0E0),
              child: Icon(Icons.person, size: 18, color: Colors.grey),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // Search bar (non-functional, UI only)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 8),
                Text('Search jobs, challenges...', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          // Legitimate job card (does nothing)
          _JobCard(
            company: 'Google',
            role: 'Software Engineering Intern',
            salary: '₹80,000/month',
            location: 'Bangalore (Hybrid)',
            tags: ['Verified', 'Top Company'],
            tagColor: Colors.green,
            logoLetter: 'G',
            logoColor: const Color(0xFF4285F4),
            isScam: false,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('This is a legitimate listing. Try the highlighted one!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          // Another legit card
          _JobCard(
            company: 'Infosys',
            role: 'UI/UX Design Intern',
            salary: '₹25,000/month',
            location: 'Pune (Remote)',
            tags: ['Verified'],
            tagColor: Colors.green,
            logoLetter: 'I',
            logoColor: const Color(0xFF007CC2),
            isScam: false,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('This is a legitimate listing. Try the highlighted one!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          // SCAM card — highlighted with notification glow
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '🔔 New notification match',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              _JobCard(
                company: 'TechMinds Solutions Pvt Ltd',
                role: 'Remote Software Intern',
                salary: '₹40,000/month ✨',
                location: 'Work from Home',
                tags: ['URGENT', 'Limited Slots'],
                tagColor: Colors.red,
                logoLetter: 'T',
                logoColor: Colors.deepOrange,
                isScam: true,
                highlight: true,
                onTap: () => Navigator.pushNamed(context, '/sim3-job-detail'),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Another legit card below
          _JobCard(
            company: 'Wipro',
            role: 'Data Science Trainee',
            salary: '₹30,000/month',
            location: 'Chennai',
            tags: ['Verified'],
            tagColor: Colors.green,
            logoLetter: 'W',
            logoColor: const Color(0xFF9C27B0),
            isScam: false,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('This is a legitimate listing. Try the highlighted one!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final String company;
  final String role;
  final String salary;
  final String location;
  final List<String> tags;
  final Color tagColor;
  final String logoLetter;
  final Color logoColor;
  final bool isScam;
  final bool highlight;
  final VoidCallback onTap;

  const _JobCard({
    required this.company,
    required this.role,
    required this.salary,
    required this.location,
    required this.tags,
    required this.tagColor,
    required this.logoLetter,
    required this.logoColor,
    required this.isScam,
    required this.onTap,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: highlight
              ? Border.all(color: Colors.orange, width: 2)
              : Border.all(color: Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: highlight
                  ? Colors.orange.withValues(alpha:0.2)
                  : Colors.black.withValues(alpha:0.05),
              blurRadius: highlight ? 10 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: logoColor.withValues(alpha:0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      logoLetter,
                      style: TextStyle(
                        color: logoColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        company,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        role,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.bookmark_border, color: Colors.grey, size: 20),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.currency_rupee, size: 14, color: Colors.green),
                Text(
                  salary,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 14),
                const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                Text(
                  location,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ...tags.map(
                  (tag) => Container(
                    margin: const EdgeInsets.only(right: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: tagColor.withValues(alpha:0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 11,
                        color: tagColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
