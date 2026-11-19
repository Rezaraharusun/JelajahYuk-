import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/travel_widgets.dart';

// Halaman detail destinasi wisata
/// Menampilkan informasi lengkap dari destinasi wisata yang dipilih pengguna.
class DestinationDetailScreen extends StatefulWidget {
  final Destination destination;

  const DestinationDetailScreen({super.key, required this.destination});

  @override
  State<DestinationDetailScreen> createState() =>
      _DestinationDetailScreenState();
}

/// Mengelola status simpan atau favorit dan berbagi pada halaman detail.
class _DestinationDetailScreenState extends State<DestinationDetailScreen> {
  // Status untuk menyimpan destinasi sebagai favorit
  bool isSaved = false;

  // Fungsi untuk menyimpan atau menghapus favorit
  /// Mengubah status favorit destinasi dan menampilkan pesan kepada pengguna.
  void toggleSave() {
    setState(() {
      isSaved = !isSaved;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isSaved
              ? 'Destinasi berhasil disimpan!'
              : 'Destinasi dihapus dari simpanan.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Fungsi untuk membagikan informasi destinasi
  /// Menyalin ringkasan destinasi ke clipboard agar dapat dibagikan pengguna.
  Future<void> shareDestination() async {
    final destination = widget.destination;

    final shareText =
        '''
Jelajahi ${destination.name} bersama JelajahYuk!

Lokasi: ${destination.location}

${destination.description}

Temukan destinasi wisata menarik bersama JelajahYuk!
''';

    // Menyalin informasi destinasi ke clipboard
    await Clipboard.setData(ClipboardData(text: shareText));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Informasi destinasi berhasil disalin!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      // AppBar halaman detail
      appBar: AppBar(
        backgroundColor: const Color(0xFF087E8B),
        foregroundColor: Colors.white,
        title: const Text(
          'Detail Destinasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // Tombol simpan favorit
          IconButton(
            onPressed: toggleSave,
            tooltip: 'Simpan destinasi',
            icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
          ),

          // Tombol berbagi destinasi
          IconButton(
            onPressed: shareDestination,
            tooltip: 'Bagikan destinasi',
            icon: const Icon(Icons.share_outlined),
          ),

          const SizedBox(width: 8),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar utama destinasi
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      destination.image,
                      width: double.infinity,
                      height: 280,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 280,
                          color: Colors.grey.shade300,
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 60,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Nama tempat wisata
                  Text(
                    destination.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF087E8B),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Informasi lokasi destinasi
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5F4F3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFF087E8B),
                          size: 27,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Lokasi Wisata',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                destination.location,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Judul deskripsi
                  const Text(
                    'Tentang Destinasi',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  // Keterangan tempat wisata
                  Text(
                    destination.description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.7,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Tombol kembali ke halaman utama
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Kembali ke halaman sebelumnya
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text(
                        'Kembali ke Halaman Utama',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF087E8B),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

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
        ),
      ),
    );
  }
}
