import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// WIDGET 1: Pencarian tempat wisata
class SearchWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchWidget({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Cari tempat wisata...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// WIDGET 2: Tombol berbagi aplikasi
class ShareWidget extends StatelessWidget {
  const ShareWidget({super.key});

  Future<void> shareApp(BuildContext context) async {
    // Menyalin informasi aplikasi ke clipboard
    await Clipboard.setData(
      const ClipboardData(
        text: 'Yuk jelajahi berbagai tempat wisata bersama JelajahYuk!',
      ),
    );

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Informasi aplikasi berhasil disalin!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => shareApp(context),
      icon: const Icon(Icons.share_outlined),
      tooltip: 'Bagikan aplikasi',
      style: IconButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF087E8B),
      ),
    );
  }
}

// WIDGET 3: Informasi lokasi wisata
class LocationWidget extends StatelessWidget {
  final String location;

  const LocationWidget({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE5F4F3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Color(0xFF087E8B), size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lokasi Destinasi',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
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
    );
  }
}

// MODEL DATA: Informasi tempat wisata
class Destination {
  final String name;
  final String location;
  final String image;
  final String description;

  const Destination({
    required this.name,
    required this.location,
    required this.image,
    required this.description,
  });
}

// WIDGET: Kartu tempat wisata

class DestinationCard extends StatelessWidget {
  final Destination destination;

  // Callback ketika kartu wisata diklik
  final VoidCallback onTap;

  const DestinationCard({
    super.key,
    required this.destination,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,

        // Tampilan kartu wisata
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar tempat wisata
              Image.network(
                destination.image,
                height: 155,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 155,
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.image_not_supported, size: 40),
                    ),
                  );
                },
              ),

              // Informasi destinasi
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destination.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 7),

                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Color(0xFF087E8B),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              destination.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Expanded(
                        child: Text(
                          destination.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),

                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Lihat Detail →',
                          style: TextStyle(
                            color: Color(0xFF087E8B),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
