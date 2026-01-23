import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bookroom/login.dart';

class Registrati extends StatefulWidget {
  const Registrati({super.key});

  @override
  State<Registrati> createState() => _RegistratiState();
}

class _RegistratiState extends State<Registrati> {
  // CONTROLLER per i campi
  final nomeController = TextEditingController();
  final cognomeController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confermaPasswordController = TextEditingController();

  final supabase = Supabase.instance.client;

  // FUNZIONE REGISTRAZIONE
  Future<void> registraUtente() async {
    if (passwordController.text != confermaPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Le password non coincidono")),
      );
      return;
    }

    try {
      // 1️⃣ Registrazione utente in Auth
      final response = await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
      );

      final user = response.user;
      if (user == null) throw "Errore nella creazione dell'utente";

      // 2️⃣ Inserimento dati nella tabella 'utenti'
      await supabase.from('utenti').upsert({
        'id': user.id, // deve corrispondere all'ID Auth
        'nome': nomeController.text,
        'cognome': cognomeController.text,
        'email': emailController.text,
      });
      // Notifica avvenuta registrazione
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registrazione completata!")),
      );

      // Vai al LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Errore: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.restaurant_menu,
                  size: 70,
                  color: Color(0xFF2BB9A9),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Benvenuto",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "registrati con un click.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),

                // Nome
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    labelText: "Nome",
                    hintText: "il tuo nome",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Cognome
                TextField(
                  controller: cognomeController,
                  decoration: InputDecoration(
                    labelText: "Cognome",
                    hintText: "il tuo cognome",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Email
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "your@email.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Conferma Password
                TextField(
                  controller: confermaPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Conferma Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Bottone Registrati
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2BB9A9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: registraUtente,
                    child: const Text(
                      "Registrati",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Divider OR
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text("OR"),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),
                const SizedBox(height: 30),

                // Link Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Hai già un account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        "Accedi",
                        style: TextStyle(
                          color: Color(0xFF2BB9A9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
