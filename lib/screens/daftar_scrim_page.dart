import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DaftarScrimPage extends StatefulWidget {
  const DaftarScrimPage({super.key});

  @override
  State<DaftarScrimPage> createState() => _DaftarScrimPageState();
}

class _DaftarScrimPageState extends State<DaftarScrimPage> {
  final TextEditingController _searchController =
      TextEditingController();

  String _searchQuery = '';

  List<dynamic> scrims = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchScrims();
  }

  Future<void> fetchScrims() async {
    try {
      final response = await Supabase.instance.client
          .from('scrims')
          .select()
          .order('created_at', ascending: false);

      setState(() {
        scrims = response;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetch scrims: $e');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredScrims = scrims.where((scrim) {
      final title =
          scrim['title'].toString().toLowerCase();

      return title.contains(
        _searchQuery.toLowerCase(),
      );
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Daftar Scrim',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),

            child: TextField(
              controller: _searchController,

              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },

              decoration: InputDecoration(
                hintText: 'Cari scrim...',
                prefixIcon: const Icon(Icons.search),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),

                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : filteredScrims.isEmpty
                    ? const Center(
                        child: Text(
                          'Tidak ada scrim',
                        ),
                      )
                    : ListView.builder(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),

                        itemCount:
                            filteredScrims.length,

                        itemBuilder: (context, index) {
                          final scrim =
                              filteredScrims[index];

                          return _buildScrimCard(
                            title: scrim['title'] ??
                                'No Title',

                            imageUrl:
                                scrim['image_url'] ??
                                    '',

                            prize:
                                scrim['prize'] ??
                                    '-',

                            entryFee:
                                scrim['entry_fee'] ??
                                    '-',

                            slot:
                                '${scrim['filled_slots']}/${scrim['total_slots']} Slot',
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrimCard({
    required String title,
    required String imageUrl,
    required String prize,
    required String entryFee,
    required String slot,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(
              top: Radius.circular(16),
            ),

            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 180,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.image,
                        size: 50,
                      ),
                    ),
                  ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      color: Colors.orange,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      'Prize: $prize',
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.payments,
                      color: Colors.green,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      'Entry: $entryFee',
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.people,
                      color: Colors.blue,
                    ),

                    const SizedBox(width: 8),

                    Text(slot),
                  ],
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: () {},

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.orange,

                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 14,
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),
                      ),
                    ),

                    child: const Text(
                      'Join Scrim',

                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
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