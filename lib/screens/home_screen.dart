import 'destination_detail_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/travel_widgets.dart';

/// Halaman utama yang menyapa pengguna dan menampilkan rekomendasi wisata.
class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// Mengelola kata kunci pencarian dan data destinasi yang ditampilkan.
class _HomeScreenState extends State<HomeScreen> {
  // Menyimpan kata kunci pencarian
  String searchQuery = '';

  // Data contoh tempat wisata
  /// Data contoh destinasi yang menjadi sumber daftar wisata pada halaman utama.
  final List<Destination> destinations = const [
    Destination(
      name: 'Pantai Parangtritis',
      location: 'Kretek, Bantul',
      image: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
      description:
          'Nikmati pemandangan pantai dan matahari terbenam yang indah.',
    ),
    Destination(
      name: 'Candi Prambanan',
      location: 'Sleman, Yogyakarta',
      image: 'https://images.unsplash.com/photo-1604999333679-b86d54738315',
      description:
          'Wisata sejarah dan budaya dengan bangunan candi yang megah.',
    ),
    Destination(
      name: 'HeHa Ocean View',
      location: 'Gunungkidul, Yogyakarta',
      image: 'https://images.unsplash.com/photo-1518837695005-2083093ee35b',
      description: 'Menikmati panorama laut dari kawasan perbukitan.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Memfilter destinasi berdasarkan nama atau lokasi sesuai kata kunci pengguna.
    final filteredDestinations = destinations.where((destination) {
      final name = destination.name.toLowerCase();
      final location = destination.location.toLowerCase();
      final query = searchQuery.toLowerCase();

      return name.contains(query) || location.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF087E8B),
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.travel_explore),
            SizedBox(width: 8),
            Text('JelajahYuk', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: const [
          // Tombol berbagi aplikasi
          Padding(padding: EdgeInsets.only(right: 12), child: ShareWidget()),
        ],
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Menyesuaikan jumlah kolom berdasarkan lebar layar
            final crossAxisCount = constraints.maxWidth >= 750 ? 3 : 2;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sapaan pengguna
                      Text(
                        'Halo, ${widget.userName}! 👋',
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        'Mau menjelajahi tempat wisata mana hari ini?',
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 22),

                      // Widget pencarian
                      SearchWidget(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      // Banner utama
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: const Color(0xFF087E8B),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Explore Your World!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Temukan keindahan wisata Indonesia '
                              'bersama JelajahYuk.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 22),

                      // Widget lokasi
                      const LocationWidget(location: 'Yogyakarta, Indonesia'),

                      const SizedBox(height: 25),

                      // Judul daftar wisata
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Rekomendasi Wisata',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${filteredDestinations.length} tempat',
                            style: const TextStyle(
                              color: Color(0xFF087E8B),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // Daftar wisata responsif
                      if (filteredDestinations.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(30),
                          child: Center(
                            child: Text(
                              'Tempat wisata tidak ditemukan.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      else
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredDestinations.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 14,
                                mainAxisExtent: 280,
                              ),
                          itemBuilder: (context, index) {
                            // Mengambil data destinasi berdasarkan index
                            final destination = filteredDestinations[index];

                            return DestinationCard(
                              destination: destination,

                              // Fungsi ketika kartu wisata ditekan
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DestinationDetailScreen(
                                        destination: destination,
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),

                      const SizedBox(height: 25),
                      const Center(
                        child: Text(
                          'JelajahYuk © 2026',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
