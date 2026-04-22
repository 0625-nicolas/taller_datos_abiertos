import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taller_datos_abiertos/config/api_constants.dart';
import 'package:taller_datos_abiertos/models/region_model.dart';
import 'package:taller_datos_abiertos/models/department_model.dart';
import 'package:taller_datos_abiertos/models/president_model.dart';
import 'package:taller_datos_abiertos/models/attraction_model.dart';

class ApiService {
  
  Future<List<RegionModel>> getRegions() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.regions}'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => RegionModel.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar las regiones');
    }
  }

  Future<List<DepartmentModel>> getDepartments() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.departments}'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => DepartmentModel.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar los departamentos');
    }
  }

  Future<List<PresidentModel>> getPresidents() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.presidents}'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => PresidentModel.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar los presidentes');
    }
  }

  Future<List<AttractionModel>> getAttractions() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.attractions}'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => AttractionModel.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar las atracciones');
    }
  }
}