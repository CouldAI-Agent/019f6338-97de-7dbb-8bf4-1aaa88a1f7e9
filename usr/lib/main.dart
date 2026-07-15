import 'package:flutter/material.dart';

void main() {
  runApp(const EkstraApp());
}

class EkstraApp extends StatelessWidget {
  const EkstraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presentasi Ekstrakurikuler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          displayMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          headlineMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationScreen(),
      },
    );
  }
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SlideData> slides = [
    SlideData(
      title: "DAFTAR EKSTRAKURIKULER\nSMP SANTA MARIA DELLA STRADA",
      subtitle: "TAHUN AJARAN 2026/2027",
      imageUrl: "https://images.unsplash.com/photo-1523050854058-8df90110c9f1?q=80&w=1200&auto=format&fit=crop",
      isTitle: true,
    ),
    SlideData(
      title: "Pramuka (Wajib Kelas 7)",
      subtitle: "Membentuk siswa disiplin, mandiri, dan aktif.\n\nPelatih: Kakak Pembina\nWaktu: Rabu (12.30 - 13.45)",
      imageUrl: "https://images.unsplash.com/photo-1517164850305-99a3e658d248?q=80&w=1200&auto=format&fit=crop",
    ),
    SlideData(
      title: "Bidang Olahraga",
      subtitle: "• Futsal (Yohanis Elwin, S.Pd.)\n  Senin & Kamis: 14.00 - 15.30\n\n• Bulu Tangkis (Ricky)\n  Senin: 14.00 - 15.30\n\n• Basket (Joshua)\n  Selasa & Jumat: 14.00 - 15.30",
      imageUrl: "https://images.unsplash.com/photo-1461896836934-ffe607ba8211?q=80&w=1200&auto=format&fit=crop",
    ),
    SlideData(
      title: "Bidang Bahasa",
      subtitle: "• English Club (Irene Uru Mali, S.Pd.)\n  Selasa: 14.00 - 15.30\n\n• Mandarin Club (Silviana Octaviana S., S.Hum.)\n  Selasa: 14.00 - 15.30",
      imageUrl: "https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?q=80&w=1200&auto=format&fit=crop",
    ),
    SlideData(
      title: "Bidang Akademik",
      subtitle: "• Club Matematika (Hendrikus Kasa I., M.Pd.)\n  Selasa: 14.00 - 15.30\n\n• Club IPS (Cycilia Ernayani P., S.Pd.)\n  Selasa: 14.00 - 15.30\n\n• Club SAINT (Desi Sri Hartaty & Yosie Margaretha)\n  Selasa: 14.00 - 15.30",
      imageUrl: "https://images.unsplash.com/photo-1532094349884-543bc11b234d?q=80&w=1200&auto=format&fit=crop",
    ),
    SlideData(
      title: "Bidang Kesenian",
      subtitle: "• Tari Tradisional (Theresia Eva, S.Pd.)\n  Selasa: 14.00 - 15.30",
      imageUrl: "https://images.unsplash.com/photo-1516280440502-3f112e5fb750?q=80&w=1200&auto=format&fit=crop",
    ),
    SlideData(
      title: "Terima Kasih!",
      subtitle: "Mari kembangkan bakat dan minatmu bersama\nSMP Santa Maria Della Strada.",
      imageUrl: "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?q=80&w=1200&auto=format&fit=crop",
      isTitle: true,
    ),
  ];

  void _nextPage() {
    if (_currentPage < slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: slides.length,
            itemBuilder: (context, index) {
              return SlideWidget(data: slides[index]);
            },
          ),
          
          // Navigation Controls
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: _prevPage,
                ),
                const SizedBox(width: 20),
                Text(
                  "\${_currentPage + 1} / \${slides.length}",
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 30),
                  onPressed: _nextPage,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SlideData {
  final String title;
  final String subtitle;
  final String imageUrl;
  final bool isTitle;

  SlideData({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.isTitle = false,
  });
}

class SlideWidget extends StatelessWidget {
  final SlideData data;

  const SlideWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(data.imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: data.isTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                textAlign: data.isTitle ? TextAlign.center : TextAlign.left,
                style: data.isTitle 
                    ? Theme.of(context).textTheme.displayMedium?.copyWith(height: 1.2)
                    : Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.amberAccent),
              ),
              const SizedBox(height: 30),
              Text(
                data.subtitle,
                textAlign: data.isTitle ? TextAlign.center : TextAlign.left,
                style: data.isTitle
                    ? Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white70)
                    : Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5, fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
