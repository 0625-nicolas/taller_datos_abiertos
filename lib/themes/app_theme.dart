import 'package:flutter/material.dart';

class AppTheme {
  // Paleta de colores colombiana
  static const Color amarilloColombia = Color(0xFFFFCD00);
  static const Color azulColombia = Color(0xFF003087);
  static const Color rojoColombia = Color(0xFFC8102E);
  static const Color fondo = Color(0xFFFAFAFA);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: fondo,
      colorScheme: ColorScheme.fromSeed(
        seedColor: amarilloColombia,
        primary: azulColombia,
        secondary: amarilloColombia,
        error: rojoColombia,
      ),
      // CORRECCIÓN: Usamos AppBarThemeData para las versiones recientes de Flutter
      appBarTheme: const AppBarThemeData(
        backgroundColor: azulColombia,
        foregroundColor: Colors.white, // Color del texto y flechas
        centerTitle: true,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      // CORRECCIÓN: Usamos CardThemeData para evitar el error de tipado
      cardTheme: const CardThemeData(
        elevation: 3,
        color: Colors.white,
        surfaceTintColor: Colors.transparent, // Evita que Material 3 tiña la tarjeta
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        clipBehavior: Clip.antiAlias, // Permite que las imágenes respeten los bordes curvos
      ),
    );
  }
} 