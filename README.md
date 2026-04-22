# Taller Datos Abiertos - API Colombia

Esta es una aplicación móvil desarrollada en **Flutter** que consume datos abiertos proporcionados por la [API Colombia](https://api-colombia.com/). El proyecto demuestra la implementación de un consumo de servicios web moderno, aplicando separación por capas (Clean Architecture), enrutamiento declarativo y un diseño visual basado en **Material 3**.

---

## 📡 API y Endpoints Seleccionados

El proyecto se nutre de la información pública de Colombia. El endpoint base utilizado es: `https://api-colombia.com/api/v1`

Se seleccionaron los siguientes 4 endpoints para la demostración:
1. **Regiones:** `/Region` - Listado de las regiones naturales del país.
2. **Departamentos:** `/Department` - División política y administrativa.
3. **Presidentes:** `/President` - Histórico de los presidentes de la república.
4. **Atracciones Turísticas:** `/TouristicAttraction` - Sitios de interés cultural y turístico.

---

## Arquitectura y Estructura del Proyecto

El código fuente está estrictamente organizado por capas de responsabilidad dentro de la carpeta `lib/` para garantizar la escalabilidad y el mantenimiento:

* 📁 `config/`: Archivos de configuración global, incluyendo constantes y la abstracción segura para la carga de variables de entorno (`.env`).
* 📁 `models/`: Clases de datos (POJOs) encargadas de modelar el dominio. Contienen los métodos de factoría `fromJson` para parsear las respuestas HTTP con tipado fuerte.
* 📁 `routes/`: Configuración centralizada de las rutas de la aplicación.
* 📁 `services/`: Capa de red. Contiene la lógica aislada para realizar las peticiones HTTP (`GET`) mediante el paquete `http` y manejar las excepciones.
* 📁 `themes/`: Configuración global de diseño (Material 3), definiendo la paleta de colores colombiana y las formas orgánicas (`AppTheme`).
* 📁 `views/`: Capa de presentación. Contiene las pantallas (Dashboard, Listado, Detalle). Solo interactúan con los servicios para solicitar datos, sin contener lógica de negocio dura.

---

## Capturas de Pantalla 

<div align="center">
  <img src="https://github.com/user-attachments/assets/0cd6b2b9-417a-40c7-b31e-901555e15eb7" width="32%" alt="Captura 1" />
  <img src="https://github.com/user-attachments/assets/708db085-0c0c-4c87-aed5-9d99eb52ee9c" width="32%" alt="Captura 2" />
  <img src="https://github.com/user-attachments/assets/cc9bff36-7eef-4615-8de6-159a0591eb3c" width="32%" alt="Captura 3" />
  <br><br> 
  <img src="https://github.com/user-attachments/assets/a323f4f9-7c99-4a3f-81fd-63d5802d5ed2" width="32%" alt="Captura 4" />
  <img src="https://github.com/user-attachments/assets/785a1523-7a92-4363-a810-898e947bee5a" width="32%" alt="Captura 5" />
  <img src="https://github.com/user-attachments/assets/e02a71ab-ea9b-4986-ba3f-e00994210b94" width="32%" alt="Captura 6" />
</div>

## Enrutamiento (go_router)

La navegación fluida y sin contexto profundo se implementó utilizando el paquete `go_router`. Las rutas definidas son:

* **`/` (DashboardView):** Pantalla principal. Muestra las tarjetas de los endpoints.
* **`/list/:endpoint` (DataListView):** Pantalla dinámica. Recibe el nombre del endpoint como parámetro de ruta (`Path Parameter`) para determinar qué servicio HTTP consumir y adaptar el título del AppBar.
* **`/detail` (DetailView):** Vista de información completa. Recibe un objeto complejo (Map) mediante la propiedad `extra` del estado de enrutamiento para mostrar el detalle sin necesidad de volver a hacer una petición a la API.

---

## Manejo de Estados Visuales

La pantalla de listado (`DataListView`) gestiona de forma reactiva el ciclo de vida de la petición HTTP utilizando el widget `FutureBuilder`, contemplando 4 estados fundamentales:

1. **Cargando:** Muestra un `CircularProgressIndicator` y un texto descriptivo mientras se espera el código de respuesta.
2. **Error:** Tolerancia a fallos. Si no hay internet o la API responde con error, se muestra un Icono de alerta y el detalle de la excepción, evitando cierres inesperados (Crashes).
3. **Vacío (Empty State):** Si la petición es exitosa pero la lista viene vacía, se notifica al usuario visualmente.
4. **Éxito:** Se renderiza un `ListView.builder` con las tarjetas de información listas para interactuar.

---

## 💻 Ejemplo de Respuesta JSON

Al realizar una petición `GET` al endpoint `https://api-colombia.com/api/v1/Region`, la aplicación procesa una respuesta con esta estructura:

```json
[
  {
    "id": 1,
    "name": "Andina",
    "description": "La región Andina es una de las seis regiones naturales de Colombia. Está ubicada en el centro del país...",
    "departments": null
  },
  {
    "id": 2,
    "name": "Caribe",
    "description": "La región Caribe de Colombia es la región natural continental y marítima más septentrional del país...",
    "departments": null
  }
]
