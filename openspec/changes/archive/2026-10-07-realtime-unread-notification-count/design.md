## Contexto

`UnreadCountWidget` lee `NotificationsCubit` e inicia una solicitud del contador de no leídas al inicializarse. `NavigationPage.initSocket` ya está suscrito al canal privado de notificaciones y muestra un aviso por cada evento `notification.received`. El listener del canal privado en `SocketService` también llama a la API del contador, pero descarta el resultado `Either`; por consiguiente, ningún `NotificationsState` nuevo llega al indicador.

El `NotificationCountUseCase` existente ya proporciona el contador autoritativo del servidor, por lo que no es necesario interpretar los datos del evento.

## Objetivos y exclusiones

**Objetivos:**

- Actualizar el contador de no leídas cada vez que llegue el evento de notificación al que la aplicación está suscrita y emitir un estado que reconstruya el indicador existente.
- Conservar la carga inicial del contador y el aviso de notificación.
- Mantener `SocketService` genérico eliminando la llamada específica de notificaciones a la API desde su listener de canales privados.

**Fuera de alcance:**

- Cambiar el protocolo websocket, la API de notificaciones o los datos del evento.
- Calcular el nuevo contador incrementando un valor del lado del cliente.
- Rediseñar el listado, la lectura o la eliminación de notificaciones.

## Decisiones

- **Usar el caso de uso existente del contador en `NotificationsCubit` para las actualizaciones websocket.** El callback del evento en `NavigationPage` solicitará un contador actualizado mediante el cubit compartido. Así se reutiliza el flujo de estado que consume `UnreadCountWidget`, en lugar de añadir otra fuente de conteo o acoplar `SocketService` a los datos de notificaciones.
- **Considerar autoritativo el endpoint del servidor.** El indicador no usa actualmente la estructura de datos del evento; consultar el contador evita suposiciones sobre sus campos y contempla eventos que podrían representar más de una notificación no leída.
- **Conservar el callback del aviso websocket.** La actualización del contador se añade al comportamiento actual; no debe reemplazar la notificación visual para el usuario.
- **Eliminar la solicitud de conteo sin uso de `SocketService`.** El servicio debe entregar los eventos de canales privados al callback sin realizar solicitudes específicas de notificaciones cuyo resultado se descarta.

## Riesgos y compensaciones

- **La actualización del indicador depende de que la API del contador responda después del evento.** La interfaz no puede mostrar el nuevo valor autoritativo antes de recibir esa respuesta; se reutilizará el estado de error existente y se mantendrá el comportamiento de carga inicial.
- **Una frecuencia alta de eventos puede generar solicitudes repetidas del contador.** Inicialmente se hará una actualización por cada evento recibido; solo se agruparán solicitudes si el volumen observado lo justifica.

## Plan de migración

No se requiere migración de datos ni del servidor. Se desplegará el cambio en el cliente y, para revertirlo, bastará con revertir ese cambio. El evento websocket y el endpoint del contador existentes seguirán siendo compatibles.

## Preguntas abiertas

Ninguna. La suscripción al evento y el endpoint del contador de no leídas existentes proporcionan los datos necesarios.
