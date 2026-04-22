import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  // Verificamos si dotenv se inicializó correctamente para evitar el error en pantalla
  static String get baseUrl {
    if (dotenv.isInitialized) {
      return dotenv.env['API_BASE_URL'] ?? 'https://api-colombia.com/api/v1';
    }
    // Fallback seguro si el .env falla
    return 'https://api-colombia.com/api/v1';
  }
  
  static const String regions = '/Region';
  static const String departments = '/Department';
  static const String presidents = '/President';
  static const String attractions = '/TouristicAttraction';
}