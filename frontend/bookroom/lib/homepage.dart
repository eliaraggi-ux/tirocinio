import 'package:flutter/material.dart';

class AvailableTablesPage extends StatefulWidget {
  const AvailableTablesPage({super.key});

  @override
  State<AvailableTablesPage> createState() => _AvailableTablesPageState();
}

class _AvailableTablesPageState extends State<AvailableTablesPage> {
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
        selectedItemColor: const Color(0xFF2BB9A9),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Bookings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
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
                "CURRENT STATUS",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Available Tables",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // FILTER BUTTONS
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    final bool isSelected = selectedFilter == index;

                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF2BB9A9)
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              filters[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight:
                                    isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

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
