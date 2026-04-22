import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taller_datos_abiertos/services/api_service.dart';
import 'package:taller_datos_abiertos/models/president_model.dart';

class DataListView extends StatefulWidget {
  final String endpointTitle;
  const DataListView({super.key, required this.endpointTitle});

  @override
  State<DataListView> createState() => _DataListViewState();
}

class _DataListViewState extends State<DataListView> {
  final ApiService _apiService = ApiService();
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    if (widget.endpointTitle == 'Regiones') {
      _futureData = _apiService.getRegions();
    } else if (widget.endpointTitle == 'Departamentos') {
      _futureData = _apiService.getDepartments();
    } else if (widget.endpointTitle == 'Presidentes') {
      _futureData = _apiService.getPresidents();
    } else if (widget.endpointTitle == 'Atracciones') {
      _futureData = _apiService.getAttractions();
    } else {
      _futureData = Future.value([]); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.endpointTitle)),
      body: FutureBuilder<List<dynamic>>(
        future: _futureData,
        builder: (context, snapshot) {
          
          // ==========================================
          // 1. ESTADO: CARGANDO (Loading)
          // ==========================================
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Usa el color primario del tema (Azul Colombia)
                  CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Cargando $widget.endpointTitle...',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          } 
          
          // ==========================================
          // 2. ESTADO: ERROR (Falla de internet o API)
          // ==========================================
          else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Usa el color de error del tema (Rojo Colombia)
                    Icon(
                      Icons.error_outline, 
                      size: 72, 
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '¡Uy, algo salió mal!',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No pudimos conectar con la API de Colombia. Verifica tu internet e intenta de nuevo.\n\nDetalle: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          } 
          
          // ==========================================
          // 3. ESTADO: VACÍO (Éxito, pero sin datos)
          // ==========================================
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.travel_explore, 
                    size: 72, 
                    // Usa el color secundario del tema (Amarillo Colombia)
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No encontramos datos aquí.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }

          // ==========================================
          // 4. ESTADO: ÉXITO (Datos listos para pintar)
          // ==========================================
          final data = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              
              String displayTitle = item.name;
              if (item is PresidentModel) {
                displayTitle = '${item.name} ${item.lastName}';
              }

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      displayTitle[0].toUpperCase(),
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    displayTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios, 
                    size: 16, 
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () {
                    context.push('/detail', extra: {
                      'title': displayTitle,
                      'description': item.description,
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}