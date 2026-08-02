import 'package:flutter/material.dart';
import 'detail_artikel.dart'; // Import detail artikel screen
import 'package:dentalink/core/widgets/custom_bottom_navigation_bar.dart';
import 'home_screen.dart';
import 'konsultasi.dart';
import 'notification.dart';
import 'profil_dokter.dart';

// =============================================
// 1. MODEL DATA ARTIKEL
// =============================================
class Article {
  final String title;
  final String writer;
  final String date;
  final List<String> tags;
  final bool hasImage;
  final String? imagePath; // ✅ path gambar opsional
  final String content;

  Article({
    required this.title,
    required this.writer,
    required this.date,
    required this.tags,
    this.hasImage = false,
    this.imagePath,
    required this.content,
  });
}

// =============================================
// 2. DUMMY DATA ARTIKEL
// =============================================
final List<Article> allArticles = [
  Article(
    title: 'Tips Menjaga Kesehatan Gigi tanpa perlu Periksa',
    writer: 'Dr. Rahsanopasha',
    date: '30 Agustus 2024',
    tags: const ['Kesehatan Gigi', 'Tips and Trick'],
    hasImage: true,
    imagePath: 'assets/images/Rectangle_64.png', // ✅ menggunakan asset yang ada
    content:
        'Jangan Lupa Sikat Gigi Brook.\n\nJangan keseringan minum Es teh dan kopi ya!\n\nNanti gigimu kuning.\n\nCegah sebelum terlambat.\n\nKarena biaya dokter mahal',
  ),
  Article(
    title: 'Bahaya Dot dan Empeng bagi Pertumbuhan Gigi Anak',
    writer: 'Dr. Astral',
    date: '30 Juli 2021',
    tags: const ['Kesehatan Gigi', 'Saran Dokter'],
    content:
        'Jangan Lupa Sikat Gigi 2 kali sehari brok.\n\njangan keseringan minum teh dan kopi, biar gigimu ga kuning.\n\nmanut aja gausah ngeyel.\n\nkalo ngeyel nanti ke dokter gigi loh.\n\nBIAYANYA MAHAL',
  ),
  Article(
    title: 'Hubungan Antara Kesehatan Gigi dan Kesehatan Jantung',
    writer: 'Dr. Tristand',
    date: '30 Januari 2022',
    tags: const ['Kesehatan Gigi', 'Saran Dokter', 'Tips and Trick'],
    content:
        'Teks ini adalah contoh artikel panjang. Tujuannya adalah memastikan tata letak Detail Artikel tetap baik meskipun kontennya banyak.\n\nKebersihan gigi adalah hal yang sangat penting. Walaupun artikel ini lucu, pesan utamanya tetap sama: sikat gigi! 🦷',
  ),
  Article(
    title: 'Cara Memilih Pasta Gigi Sesuai Kebutuhan Kamu',
    writer: 'Dr. Tristando',
    date: '29 Januari 2021',
    tags: const ['Saran Dokter', 'Tips and Trick'],
    content: 'ntar dulu la banyak kali bah',
  ),
];

// =============================================
// MAIN APP
// =============================================
void main() {
  runApp(const DentaLinkApp());
}

class DentaLinkApp extends StatelessWidget {
  const DentaLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DentaLink UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        fontFamily: 'Roboto',
      ),
      home: const ArticleListScreen(), // Use home instead of routes
    );
  }
}

// =============================================
// 3. TAG CHIP
// =============================================
class TagChip extends StatelessWidget {
  final String label;
  const TagChip({super.key, required this.label});

  Color _bg(String tag) {
    switch (tag.toLowerCase()) {
      case 'kesehatan gigi':
        return const Color(0xFFCCE6FF);
      case 'saran dokter':
        return const Color(0xFFFFF2CC);
      case 'tips and trick':
        return const Color(0xFFE2FAD1);
      default:
        return const Color(0xFFE0E0E0);
    }
  }

  Color _fg(String tag) {
    switch (tag.toLowerCase()) {
      case 'kesehatan gigi':
        return const Color(0xFF3C64B1);
      case 'saran dokter':
        return const Color(0xFFFFA000);
      case 'tips and trick':
        return const Color(0xFF558B2F);
      default:
        return Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _bg(label),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: _fg(label),
        ),
      ),
    );
  }
}

// =============================================
// 4. LIST SCREEN (PAKAI STATEFUL UNTUK SEARCH)
// =============================================
class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({super.key});

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  List<Article> filteredArticles = List.from(allArticles);
  String query = '';

  void _searchArticle(String input) {
    if (!mounted) return; // Guard untuk memastikan widget masih mounted

    final String lowerInput = input.toLowerCase();
    final List<Article> filtered = allArticles.where((a) {
      final title = a.title.toLowerCase();
      final writer = a.writer.toLowerCase();
      final tags = a.tags.join(' ').toLowerCase();
      return title.contains(lowerInput) ||
          writer.contains(lowerInput) ||
          tags.contains(lowerInput);
    }).toList();

    if (mounted) {
      setState(() {
        query = lowerInput;
        filteredArticles = filtered;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 1) return;
          if (!mounted) return; // Guard untuk memastikan widget masih mounted

          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const DoctorHomeScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const Konsultasi(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const NotificationScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const ProfilDokterScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
              break;
          }
        },
        items: [
          CustomBottomNavigationBarItem(icon: Icons.home_filled, label: 'Home'),
          CustomBottomNavigationBarItem(
            icon: Icons.query_stats,
            label: 'Statistik',
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.local_hospital,
            label: 'Konsultasi',
            customIcon: Image.asset(
              'assets/navbar/tooth.png',
              width: 20.0,
              height: 20.0,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, size: 20.0);
              },
            ),
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.notifications_none,
            label: 'Notifikasi',
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.account_circle,
            label: 'Profil',
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _ArticleHeaderDelegate(
              statusBarHeight: statusBarHeight,
              onSearchChanged: _searchArticle,
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, i) {
              if (i >= filteredArticles.length) {
                return const SizedBox.shrink();
              }
              final a = filteredArticles[i];
              return _ArticleCard(
                article: a,
                onTap: () {}, // Navigation now handled in _ArticleCard
              );
            }, childCount: filteredArticles.length),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

// =============================================
// CARD
// =============================================
class _ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;
  const _ArticleCard({required this.article, required this.onTap});

  // Convert tags to Map objects for compatibility with DetailArtikelScreen
  List<Map<String, dynamic>> _getArticleLabels() {
    List<Map<String, dynamic>> labels = [];
    for (String tag in article.tags) {
      Color backgroundColor, textColor, borderColor;

      switch (tag.toLowerCase()) {
        case 'kesehatan gigi':
          backgroundColor = const Color(0x8084BCEA);
          textColor = const Color(0xFF4DAFFF);
          borderColor = const Color(0xFF4DAFFF);
          break;
        case 'saran dokter':
          backgroundColor = const Color(0x80FFD700);
          textColor = const Color(0xFFB8860B);
          borderColor = const Color(0xFFB8860B);
          break;
        case 'tips and trick':
          backgroundColor = const Color(0x80A2E22B);
          textColor = const Color(0xFF537E03);
          borderColor = const Color(0xFF537E03);
          break;
        default:
          backgroundColor = const Color(0x80E0E0E0);
          textColor = Colors.black87;
          borderColor = Colors.black87;
      }

      labels.add({
        'text': tag,
        'backgroundColor': backgroundColor,
        'textColor': textColor,
        'borderColor': borderColor,
      });
    }
    return labels;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to detail_artikel screen with proper parameters
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                DetailArtikelScreen(
                  imageUrl: article.imagePath ?? '',
                  title: article.title,
                  author: article.writer,
                  date: article.date,
                  labels: _getArticleLabels(),
                  content: article.content,
                ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.hasImage && article.imagePath != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: Image.asset(
                  article.imagePath!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 160,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 160,
                      decoration: const BoxDecoration(color: Color(0xFFE8EEF8)),
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          size: 52,
                          color: Colors.white54,
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              Container(
                height: 160,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8EEF8),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                ),
                child: const Center(
                  child: Icon(Icons.image, size: 52, color: Colors.white54),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: article.tags
                        .map((t) => TagChip(label: t))
                        .toList(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 10,
                        backgroundColor: Color(0xFFBFD9FF),
                        child: Icon(
                          Icons.person,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        article.writer,
                        style: const TextStyle(
                          color: Color(0xFF74839A),
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        article.date,
                        style: const TextStyle(
                          color: Color(0xFF98A6B8),
                          fontSize: 13,
                        ),
                      ),
                    ],
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

// =============================================
// HEADER DENGAN SEARCH (PAKAI header.png)
// =============================================
class _ArticleHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double statusBarHeight;
  final ValueChanged<String> onSearchChanged;
  const _ArticleHeaderDelegate({
    required this.statusBarHeight,
    required this.onSearchChanged,
  });

  @override
  double get minExtent => 140.0 + statusBarHeight;
  @override
  double get maxExtent => 200.0 + statusBarHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double shrinkFactor = (shrinkOffset / (maxExtent - minExtent)).clamp(
      0.0,
      1.0,
    );

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2158A1), Color(0xFF4DAFFF)],
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.22),
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, statusBarHeight + 10, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (Navigator.canPop(context)) Navigator.pop(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Kembali',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Artikel DentaLink',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30 * (1 - shrinkFactor * 0.5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: TextField(
                  onChanged: onSearchChanged,
                  decoration: const InputDecoration(
                    hintText: 'Cari artikel...',
                    hintStyle: TextStyle(color: Color(0xFF9BB7F6)),
                    prefixIcon: Icon(Icons.search, color: Color(0xFF9BB7F6)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 10,
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

  @override
  bool shouldRebuild(_ArticleHeaderDelegate old) => true;
}
