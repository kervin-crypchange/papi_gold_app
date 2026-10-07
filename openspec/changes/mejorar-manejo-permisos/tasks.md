## 1. Auditar el uso actual de permisos

- [x] 1.1 Identificar todos los consumidores de `PermissionService`, `LocationService` y las funciones de cámara, fotos, ubicación y notificaciones en Dart y configuración nativa.
- [x] 1.2 Confirmar qué permisos corresponden a funciones implementadas y documentar los permisos Android/iOS que deben conservarse.

## 2. Centralizar la consulta y solicitud de permisos

- [ ] 2.1 Actualizar `PermissionService` para exponer estados detallados y permitir que los consumidores actúen ante denegación permanente, restricción o acceso limitado.
- [ ] 2.2 Eliminar la solicitud agrupada de permisos durante el arranque y mover cada solicitud al flujo de la función que la requiere.

## 3. Hacer opcional la ubicación

- [ ] 3.1 Unificar en `LocationService` la comprobación, solicitud y obtención de ubicación, representando explícitamente la ausencia de posición y persistiendo localmente el último punto elegido en el mapa.
- [ ] 3.2 Adaptar `MapWidget` para solicitar ubicación solo desde «Mi ubicación», iniciar con el último punto local o con el centro neutral y permitir selección manual sin permiso.

## 4. Sincronizar los estados en Ajustes

- [ ] 4.1 Mostrar los estados actuales de los permisos relevantes y actualizar los indicadores cuando la pantalla vuelve a estar activa tras abrir Ajustes del sistema.
- [ ] 4.2 Presentar explicaciones y acceso a Ajustes cuando el sistema no permita volver a solicitar un permiso.

## 5. Alinear permisos nativos y privacidad

- [ ] 5.1 Ajustar el manifiesto Android y las declaraciones de privacidad iOS a las capacidades confirmadas, retirando permisos sin consumidor funcional.
- [ ] 5.2 Verificar que cada función protegida tenga los textos y permisos requeridos en las plataformas donde esté disponible.

## 6. Validar escenarios de permisos

- [ ] 6.1 Añadir o actualizar pruebas de permisos concedidos, denegados, denegados permanentemente y estados restringidos o limitados.
- [ ] 6.2 Añadir o actualizar pruebas para ubicación no disponible, alternativa del mapa y actualización de Ajustes al reanudar.
- [ ] 6.3 Ejecutar las pruebas y validaciones disponibles para las plataformas afectadas, corrigiendo regresiones del flujo de permisos.
