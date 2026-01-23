import 'package:flutter/material.dart';
import 'package:bookroom/homepage.dart';
import 'package:bookroom/prenotazioni.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int selectedFilter = 0;

  final List<String> filters = [
    "All Tables",
    "2–4 People",
    "Large Groups",
    "Outdoor",
  ];

  final List<Map<String, dynamic>> tables = [
    {"table": "Table 1", "people": "4 people"},
    {"table": "Table 4", "people": "2 people"},
    {"table": "Table 7", "people": "6 people"},
    {"table": "Table 12", "people": "2 people"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
  currentIndex: 2, // questa è la pagina "Impostazioni"
  selectedItemColor: const Color(0xFF2BB9A9),
  unselectedItemColor: Colors.grey,
  onTap: (index) {
    if (index == 2) return; // sei già qui
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AvailableTablesPage()),
      );
    }

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BookedeTablesPage()),
      );
    }
  },
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

              // HEADER
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


              const SizedBox(height: 25),

              // TABLE LIST
              Expanded(
                child: ListView.builder(
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
                          // Placeholder immagine tavolo
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          const SizedBox(width: 15),

                          // Info tavolo
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                table["table"],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                table["people"],
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),

                          // BOOK NOW BUTTON
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2BB9A9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
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
