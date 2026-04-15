Fondos App
App Flutter para gestión de fondos. Integrada con Supabase.

Arquitectura
MVVM (Model-View-ViewModel) + Feature-First
Un ViewModel por vista
Capas: data → gui (con ViewModels)
lib/
├── core/           # Utilidades, constantes, servicios comunes
├── data/           # Modelos de datos y repositorios
│   ├── models/     # Modelos de datos
│   └── repositories/ # Repositorios para acceso a datos
└── gui/            # Interfaz de usuario
    ├── views/      # Vistas (Widgets principales)
    ├── viewmodels/ # ViewModels (lógica de presentación y estado)
    └── widgets/    # Widgets reutilizables
Configuración
Ejecutar
flutter pub get
flutter run
Serialización
Los modelos con @JsonSerializable generan archivos .g.dart mediante build_runner. Después de agregar o modificar un modelo, ejecuta:

dart run build_runner build --delete-conflicting-outputs
build: ejecuta una vez, termina y el terminal queda listo para el siguiente comando.
watch: se queda corriendo y regenera al guardar; el terminal permanece ocupado.
Para desarrollo con regeneración automática (terminal ocupado):

dart run build_runner watch --delete-conflicting-outputs
--delete-conflicting-outputs elimina archivos generados conflictivos antes de regenerar (útil al renombrar o eliminar modelos).

Dependencias principales
provider - State management (MVVM)
go_router - Navegación
equatable - Igualdad de objetos
json_annotation / json_serializable - Serialización JSON (modelos)
