import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:taller_datos_abiertos/routes/app_router.dart';
import 'package:taller_datos_abiertos/themes/app_theme.dart'; // Importación de tu tema

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await dotenv.load(fileName: ".env");
    print("✅ Variables de entorno cargadas correctamente.");
  } catch (e) {
    print("⚠️ Advertencia: No se pudo cargar el archivo .env. Usando URLs por defecto. Error: $e");
  }
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Datos Abiertos Colombia',
      theme: AppTheme.theme, // <-- Aquí se inyecta todo el estilo visual
      routerConfig: appRouter,
    );
  }
}