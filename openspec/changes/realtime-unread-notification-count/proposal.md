## Motivo

El indicador de navegación no refleja en tiempo real las notificaciones recién recibidas. Aunque el listener del websocket solicita actualmente el contador de notificaciones no leídas, descarta el resultado; por eso `NotificationsCubit` y `UnreadCountWidget` no cambian hasta que se realiza otra consulta.

## Cambios

- Actualizar el contador de notificaciones no leídas al recibir un evento `notification.received` por websocket y publicar el resultado mediante el estado de notificaciones existente que consume el indicador de navegación.
- Conservar la consulta inicial del contador y el aviso actual del evento de notificación.
- Eliminar la solicitud descartada del contador en el servicio genérico de sockets, para que la actualización desde el evento hasta el estado tenga un único responsable.

## Capacidades

### Capacidades nuevas

- `realtime-notification-count`: Mantener sincronizado el indicador de notificaciones no leídas con los eventos recibidos por websocket.

### Capacidades modificadas

## Impacto

- Afecta a `SocketService`, `NavigationPage`, `NotificationsCubit` y `UnreadCountWidget`.
- Reutiliza el caso de uso y la API existentes para consultar notificaciones no leídas; no se prevén cambios en la API ni en las dependencias.
