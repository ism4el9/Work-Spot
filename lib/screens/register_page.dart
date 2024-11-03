import 'package:astro_office/config/officeApi/auth.dart';
import 'package:astro_office/screens/login_page.dart';
import 'package:astro_office/screens/pay.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final bool payment;
  RegisterPage({super.key, required this.payment});

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cuenta'),
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {
        //     //funcion al regresar
        //   }, 
        //   icon: const Icon(
        //     Icons.arrow_back, 
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
              'Crear una cuenta nueva',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Completa la información para registrarte',
              style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary),
            ),
            const SizedBox(height: 30),

            // Campo de nombre
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                
              ),
            ),
            const SizedBox(height: 20),

            // Campo de correo electrónico
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // Campo de contraseña
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),

            // Botón de registrarse
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
                child: const Text('Registrarse'),
                
              ),
            ),
            const SizedBox(height: 20),

            // Enlace para ir a la pantalla de inicio de sesión
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage(payment: payment,))
                  );
                },
                child: const Text(
                  '¿Ya tienes cuenta? Inicia Sesión',
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
