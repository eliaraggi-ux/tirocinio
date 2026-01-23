import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bookroom/impostazioni.dart';
import 'package:bookroom/prenotazioni.dart';


class AvailableTablesPage extends StatefulWidget {
  const AvailableTablesPage({super.key});

  @override
  State<AvailableTablesPage> createState() => _AvailableTablesPageState();
}

class _AvailableTablesPageState extends State<AvailableTablesPage> {
  final supabase = Supabase.instance.client;

  int _currentIndex = 0;
  bool isLoading = true;
  List<Map<String, dynamic>> tables = [];

  @override
  void initState() {
    super.initState();
    fetchTables();
  }

  Future<void> fetchTables() async {
    try {
      final response = await supabase
          .from('prenotazioni')
          .select('*')
          .eq('disponibile', true);

      setState(() {
        tables = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Errore caricamento stanze: $e');
    }
  }

  void onNavTap(int index) {
    if (index == _currentIndex) return;

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BookedeTablesPage()),
      );
    }

    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SettingsPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔽 BOTTOM NAV BAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF2BB9A9),
        unselectedItemColor: Colors.grey,
        onTap: onNavTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Prenotazioni",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Impostazioni",
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const Text(
                "STATO CORRENTE",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Tavoli Disponibili",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // 📦 LISTA STANZE
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : tables.isEmpty
                        ? const Center(child: Text("Nessun tavolo disponibile"))
                        : ListView.builder(
                            itemCount: tables.length,
                            itemBuilder: (context, index) {
                              final table = tables[index];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),

                                    const SizedBox(width: 15),

                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          table['nome'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${table['capienza']} persone',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const Spacer(),

                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF2BB9A9),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        // 👉 qui andrà la prenotazione
                                      },
                                      child: const Text("Book Now"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
