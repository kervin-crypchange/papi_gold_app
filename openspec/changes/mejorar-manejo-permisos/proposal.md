## Why

La aplicación solicita varios permisos durante el arranque y descarta los resultados, mientras que ubicación puede solicitarse por dos mecanismos y el mapa asume que siempre existe una posición. Esto puede interrumpir el inicio, producir fallos cuando el usuario deniega permisos y dejar información de Ajustes desactualizada; conviene establecer un flujo consistente antes de ampliar el uso de capacidades del dispositivo.

## What Changes

- Solicitar permisos cuando la función correspondiente los necesite, en lugar de pedir cámara, fotos, ubicación y notificaciones en bloque durante el arranque.
- Exponer y tratar el estado detallado de los permisos, incluyendo denegación permanente y estados restringidos o limitados cuando la plataforma los reporte.
- Unificar la solicitud y comprobación de ubicación para evitar flujos duplicados y permitir que la app continúe sin posición del dispositivo.
- Mantener utilizable el selector de direcciones sin permiso de ubicación: solicitar la posición solo cuando el usuario pulse «Mi ubicación» y usar el último punto seleccionado localmente o un centro neutral si no hay posición.
- Actualizar los indicadores de ubicación en Ajustes al regresar desde la configuración del sistema; conservar la sección de notificaciones de la app sin pedir permiso de notificaciones del sistema, ya que no hay integración nativa de notificaciones.
- Alinear las declaraciones de permisos y descripciones de privacidad de Android e iOS con los permisos que realmente se utilizan.
- Alinear las declaraciones de permisos y descripciones de privacidad de Android e iOS con los permisos que realmente se utilizan.

## Capabilities

### New Capabilities
- `manejo-permisos`: Solicitud contextual, consulta y representación del estado de permisos del dispositivo, con manejo seguro de denegaciones y dependencias de plataforma.

### Modified Capabilities

## Impact

- `lib/main.dart`, `PermissionService`, `LocationService`, `MapWidget` y la pantalla de Ajustes.
- Declaraciones de permisos y textos de privacidad en Android e iOS.
- Flujos de cámara, fotos, ubicación y notificaciones; no se prevé añadir dependencias.
