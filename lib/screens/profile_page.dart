import 'package:astro_office/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  int _currentIndex = 0;
  
  final List<String> _routes = ['/home', '/reserved', '/profile'];
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.pushReplacementNamed(context, _routes[index]);
  }

  bool isDarkMode = false; // Estado del modo oscuro
  bool isUserLoggedIn = true; // Estado de sesión
  String userName = "Mao Astudillo"; // Nombre de usuario (por defecto es "Invitado")

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Encabezado de perfil
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.surfaceDim,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isUserLoggedIn ? userName : 'Invitado',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),

              // Botones de iniciar sesión o registrarse (si el usuario no está autenticado)
              if (!isUserLoggedIn) ...[
                ElevatedButton(
                  onPressed: () {
                    // Acción para iniciar sesión
                  },
                  style: ButtonStyle(
                    elevation: const WidgetStatePropertyAll(3.0),
                    backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
                    foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onPrimary)
                  ),
                  child: const Text('Inicia Sesión o Regístrate!'),
                  
                ),
                const Divider(height: 30),
              ],

              // Sección de configuración
              const Text(
                'Configuración',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Cambiar a Modo Oscuro
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text('Modo Oscuro'),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                      // Aquí puedes integrar el cambio de tema global
                    });
                  },
                ),
              ),

              // Modificar Datos del Perfil (si el usuario está autenticado)
              if (isUserLoggedIn)
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Modificar Datos del Perfil'),
                  onTap: () {
                    // Navegar a la pantalla de modificación del perfil
                  },
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}
