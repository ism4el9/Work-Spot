import 'package:astro_office/config/officeApi/auth.dart';
import 'package:astro_office/screens/pay.dart';
import 'package:astro_office/screens/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final bool payment;
  LoginPage({super.key, required this.payment});
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {
        //     //funcion al regresar
        //   }, 
        //   icon: const Icon(
        //     Icons.close_rounded, 
        //   ),
        // ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Text(
              'Bienvenido de nuevo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Inicia sesión para continuar',
              style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary),
            ),
            const SizedBox(height: 30),

            // Campo de correo electrónico
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                //border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // Campo de contraseña
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                //border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),

            // Botón de iniciar sesión
            SizedBox(
              width: double.infinity,
              
              child: ElevatedButton(
                onPressed: () async {
                  if(!payment){
                    AuthService().login();
                    Navigator.of(context).pop(true);
                  } 
                  else {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const PaymentPage(totalPrice: 86,)),
                      );
                      AuthService().login();
                      // Si el resultado es true, actualiza el estado de autenticación
                      if (result == true) {
                        // Navegar de regreso a HomePage con el resultado `true`
                        if (context.mounted) {
                          Navigator.of(context).pop(true);
                        }
                    }
                  }
                },
                style: ButtonStyle(
                  elevation: const WidgetStatePropertyAll(3.0),
                  backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
                  foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onPrimary)
                ),
                child: const Text('Iniciar Sesión'),            
              ),
            ),
            const SizedBox(height: 20),

            // Enlace para ir a la pantalla de registro
            Center(
              child: GestureDetector(
                onTap: () async {
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RegisterPage(payment: payment,)),
                  );

                  // Si el resultado es true, actualiza el estado de autenticación
                  if (result == true) {
                    AuthService().login();
                    // Navegar de regreso a HomePage con el resultado `true`
                    if (context.mounted) {
                      Navigator.of(context).pop(true);
                    }
                  }
                },
                child: const Text(
                  '¿No tienes cuenta? Regístrate',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
