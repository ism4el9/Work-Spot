import 'package:astro_office/config/officeApi/auth.dart';
import 'package:astro_office/config/officeApi/office_all.dart';
import 'package:astro_office/config/theme/theme_provider.dart';
import 'package:astro_office/screens/favorites_page.dart';
import 'package:astro_office/screens/login_page.dart';
import 'package:astro_office/screens/office_details.dart';
import 'package:astro_office/screens/reservation_details.dart';
import 'package:astro_office/widgets/bottom_navigation_bar.dart';
import 'package:astro_office/widgets/office_card.dart';
import 'package:astro_office/widgets/reserved_office_card.dart';
import 'package:astro_office/widgets/search_bar_no_shadow.dart';
import 'package:astro_office/widgets/search_bar_with_icons.dart';
import 'package:astro_office/widgets/shared_private_toggle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  final AuthService authService;
  bool results;

  MyHomePage({super.key, required this.authService, required this.results});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool isUserLoggedIn;
  @override
  void initState() {
    super.initState();
    // Inicia la variable isAuthenticated según el estado actual de AuthService
    isUserLoggedIn = widget.authService.checkAuthentication();
  }

  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      widget.results = false;
    });
  }

  bool isSharedSelected = false;
  bool isPrivateSelected = false;

  bool isDarkMode = false; // Estado del modo oscuro
  String userName =
      "Mao Astudillo"; // Nombre de usuario (por defecto es "Invitado")

  // Método para filtrar las oficinas según el tipo seleccionado
  List<Map<String, String>> get filteredOffices {
    return OfficeAll().allOffices.where((office) {
      if (isSharedSelected) return office['type'] == 'Compartido';
      if (isPrivateSelected) return office['type'] == 'Privado';
      return true;
    }).toList();
  }

  AppBar get appBar {
    if (_currentIndex == 1) return reservedAppBar();
    if (_currentIndex == 2) return profileAppBar();
    return homeAppBar();
  }

  Widget getBody(ThemeProvider themeProvider) {
    if (_currentIndex == 1) return reservedBody();
    if (_currentIndex == 2) return profileBody(themeProvider);
    return homeBody();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: appBar,
      body: getBody(themeProvider),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ), // Widget para la barra inferior
    );
  }

  Widget homeBody() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 15, left: 30, right: 30),
          child: SearchBarWithIcons(),
        ),
        SharedPrivateToggle(
          isSharedSelected: isSharedSelected,
          isPrivateSelected: isPrivateSelected,
          onToggle: (int buttonNum) {
            setState(() {
              if (buttonNum == 1) {
                isSharedSelected = !isSharedSelected;
                if (isSharedSelected) isPrivateSelected = false;
              }
              if (buttonNum == 2) {
                isPrivateSelected = !isPrivateSelected;
                if (isPrivateSelected) isSharedSelected = false;
              }
            });
          },
        ),
        Expanded(
        child: ListView.builder(
          itemCount: filteredOffices.length,
          itemBuilder: (context, index) {
            final office = filteredOffices[index];
            return GestureDetector(
              onTap: () async{
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OfficeDetailScreen(isUserLoggedIn: isUserLoggedIn,),
                  ),
                );

                if (result == true) {
                    setState(() {
                      isUserLoggedIn = true;
                    });
                  }
              },
              child: OfficeCard(
                imageUrl: office['imageUrl']!,
                title: office['title']!,
                description: office['description']!,
                price: office['price']!,
                type: office['type']!,
              ),
            );
          },
        ),
      ),

      ],
    );
  }

  AppBar homeAppBar() {
    if(widget.results){
      return AppBar(
        elevation: 0,
        title: Text(
          'Resultados',
          style: GoogleFonts.firaSans(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    else {
      return AppBar(
        elevation: 0,
        title: Text(
          'WorkSpot',
          style: GoogleFonts.firaSans(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      );
    }
  }

  Widget reservedBody() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: SearchBarNoShadow(),
        ),
        SharedPrivateToggle(
          isSharedSelected: isSharedSelected,
          isPrivateSelected: isPrivateSelected,
          onToggle: (int buttonNum) {
            setState(() {
              if (buttonNum == 1) {
                isSharedSelected = !isSharedSelected;
                if (isSharedSelected) isPrivateSelected = false;
              }
              if (buttonNum == 2) {
                isPrivateSelected = !isPrivateSelected;
                if (isPrivateSelected) isSharedSelected = false;
              }
            });
          },
        ),
        Expanded(
        child: ListView.builder(
          itemCount: filteredOffices.length,
          itemBuilder: (context, index) {
            final office = filteredOffices[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReservationDetailScreen(),
                  ),
                );
              },
              child: ReservedOfficeCard(
                imageUrl: office['imageUrl']!,
                title: office['title']!,
                asistants: office['asistants']!,
                time: office['time']!,
                day: office['day']!,
                name: office['name']!,
              ),
            );
          },
        ),
      ),

      ],
    );
  }

  AppBar reservedAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        'Reservas',
        style: GoogleFonts.firaSans(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ), 
      // titleSpacing: 0,
      // toolbarHeight: 105,
    );
  }

  Widget profileBody(ThemeProvider themeProvider) {
    return SingleChildScrollView(
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
                    color: Theme.of(context).colorScheme.surface,
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
                onPressed: () async {
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage(payment: false,)),
                  );

                  // Si el resultado es true, actualiza el estado de autenticación
                  if (result == true) {
                    setState(() {
                      isUserLoggedIn = true;
                    });
                  }
                },
                style: ButtonStyle(
                    elevation: const WidgetStatePropertyAll(3.0),
                    backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.primary),
                    foregroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.onPrimary)),
                child: const Text('Inicia Sesión o Regístrate!'),
              ),
              
            ],
            const Divider(height: 30),
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
              leading: Icon(Icons.dark_mode, color: Theme.of(context).colorScheme.tertiary),
              title: const Text('Modo Oscuro'),
              trailing: Switch(
                value: themeProvider.isDarkTheme,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                  setState(() {
                    isDarkMode = true;
                  });
                },
              ),
            ),

            // Modificar Datos del Perfil (si el usuario está autenticado)
            // if (isUserLoggedIn)
            //   ListTile(
            //     leading: Icon(Icons.edit, color: Theme.of(context).colorScheme.tertiary),
            //     title: const Text('Modificar Datos del Perfil'),
            //     onTap: () {
            //       // Navegar a la pantalla de modificación del perfil
            //     },
            //   ),
            if (isUserLoggedIn)
              ListTile(
                leading: Icon(Icons.bookmarks_rounded, color: Theme.of(context).colorScheme.tertiary),
                title: const Text('Guardados'),
                onTap: () async{
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritesPage(isUserLoggedIn: isUserLoggedIn,),
                    ),
                  );

                  if (result == true) {
                      setState(() {
                        isUserLoggedIn = true;
                      });
                    }
                },
              ),
            if (isUserLoggedIn)
              ListTile(
                leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.error),
                title: const Text('Cerrar Sesión'),
                onTap: () {
                  AuthService().logout();
                  setState(() {
                      isUserLoggedIn = false;
                    });
                },
              ),
          ],
        ),
      ),
    );
  }

  AppBar profileAppBar() {
    return AppBar(
      title: Text(
        'Perfil',
        style: GoogleFonts.firaSans(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0,
      
    );
  }
}
