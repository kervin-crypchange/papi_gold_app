## Context

La aplicación solicita ubicación antes de `runApp` mediante `LocationService`, y vuelve a solicitar ubicación junto con cámara, fotos y notificaciones en `MainApp`. El resultado de la solicitud agrupada no se utiliza. `LocationService` puede finalizar sin posición, aunque `MapWidget` obtiene `geoPoint` mediante un acceso no anulable. La pantalla de Ajustes consulta solo ubicación y notificaciones al inicializarse; al volver desde la configuración del sistema no actualiza esos indicadores.

La app incluye configuración Android e iOS, pero no se encontró en el código Dart inspeccionado un consumidor directo de cámara o fotos ni una integración de notificaciones del sistema; las notificaciones existentes son una lista dentro de la app. Las direcciones guardadas conservan texto, no coordenadas.

## Goals / Non-Goals

**Goals:**
- Hacer que la app pueda iniciar y navegar sin haber concedido permisos opcionales.
- Pedir cada permiso en el contexto de la función que lo necesita y actuar según su estado completo.
- Mantener utilizable el selector del mapa cuando no se obtiene ubicación, con una alternativa visible en lugar de una excepción.
- Solicitar ubicación desde la acción «Mi ubicación» y permitir la selección manual de un punto sin otorgar permiso.
- Guardar localmente el último punto elegido en el mapa y reutilizarlo como centro inicial; si no existe, usar el centro neutral `(0, 0)` con un zoom que permita ubicar el área manualmente.
- Reflejar en Ajustes el estado de ubicación al entrar y al regresar de la configuración.
- Mantener las declaraciones de permisos y textos de privacidad compatibles con las funciones realmente soportadas en Android e iOS.

**Non-Goals:**
- Añadir funciones nuevas de captura, selección de imágenes, notificaciones o localización en segundo plano.
- Solicitar permisos en segundo plano o ampliar el acceso a ubicación sin un requisito funcional explícito.
- Cambiar el comportamiento del backend o añadir dependencias.

## Decisions

1. **Retirar las solicitudes agrupadas del arranque y solicitar en el punto de uso.** El arranque no debe bloquearse esperando una decisión de permisos. El selector de direcciones puede abrirse sin ubicación; solo la acción explícita «Mi ubicación» consulta/solicita permiso y obtiene la posición. Se prefiere este enfoque a mantener un diálogo masivo porque explica el motivo y no pide capacidades sin contexto.

2. **Conservar `PermissionStatus` a través de la capa de permisos.** Las consultas no se reducirán a booleanos. La interfaz y los consumidores distinguirán concedido, denegado, denegado permanentemente y estados restringidos o limitados disponibles en la plataforma, para decidir si reintentar, mostrar una explicación o enlazar Ajustes.

3. **Unificar el flujo de ubicación detrás de `LocationService`.** El servicio será la única autoridad para comprobar/solicitar ubicación y obtener una posición opcional. Se eliminarán las solicitudes duplicadas. La falta de permiso, servicio desactivado o fallo al obtener la posición se representarán como ausencia de posición, no como un valor forzado ni como una excepción que impida usar el mapa. El último punto seleccionado se guardará localmente para reutilizarlo; si no existe, el mapa usará `(0, 0)` con zoom amplio.

4. **Actualizar Ajustes al reanudarse la app.** Al abrirse la pantalla y después de regresar del sistema, se consultará de nuevo el estado de cada permiso mostrado. Se mantendrá la configuración general del sistema como destino cuando no haya una pantalla más específica compatible.

5. **Ajustar permisos declarados a las capacidades con consumidor real.** Revisar manifiestos y claves de privacidad junto con los flujos Dart. No se solicitarán permisos de cámara, fotos o notificaciones del sistema mientras no haya un consumidor funcional; permisos de almacenamiento heredados y ubicación en segundo plano tampoco se mantendrán sin necesidad verificada. Se conservará el acceso a la lista de notificaciones dentro de la app. Esta decisión evita solicitar acceso por previsión.

## Risks / Trade-offs

- [El centro neutral `(0, 0)` no corresponde a la región del usuario en la primera visita] → Usar zoom amplio para permitir orientación manual y recordar localmente los puntos elegidos para futuras visitas; no inferir ni geocodificar direcciones de texto sin coordenadas.
- [Los estados y permisos disponibles difieren entre versiones de Android/iOS] → Usar los estados expuestos por `permission_handler` y validar las configuraciones de ambas plataformas sin asumir equivalencia exacta.
- [Eliminar declaraciones puede afectar una capacidad que no apareció en la búsqueda de Dart] → Auditar todos los consumidores y configuración nativa antes de retirar permisos; si una capacidad está implementada, conservar su declaración y trasladar su solicitud al punto de uso.
- [El usuario puede denegar la ubicación permanentemente] → Informar que la función requiere ubicación, permitir continuar sin ella y ofrecer acceso a Ajustes sin abrirlo automáticamente.

## Migration Plan

1. Cambiar el contrato del servicio de permisos y retirar la solicitud agrupada del arranque.
2. Hacer que la ubicación sea opcional, guardar el último punto del mapa y actualizar el selector y Ajustes para gestionar los estados y el ciclo de vida.
3. Ajustar declaraciones de Android/iOS tras la auditoría de consumidores, conservando la navegación de notificaciones dentro de la app.
4. Validar permisos concedidos, denegados, permanentemente denegados, servicio de ubicación desactivado, selección manual y reanudación desde Ajustes.

La migración no requiere cambios de datos ni backend. Si una plataforma deja de compilar o una capacidad existente pierde acceso, revertir solo la limpieza de configuración correspondiente hasta completar la adaptación de ese flujo.

## Open Questions

- No se encontró un uso actual de cámara o fotos en los archivos Dart revisados, aunque Ajustes muestra una fila de cámara. La implementación debe eliminar las filas de permisos sin consumidor y conservar la entrada a notificaciones de la app.
- El centro neutral para la primera apertura sin ubicación será `(0, 0)` con zoom amplio; los puntos elegidos posteriormente se guardarán en local.
