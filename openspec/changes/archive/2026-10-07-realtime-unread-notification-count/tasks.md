## 1. Conectar los eventos websocket con el estado de notificaciones

- [x] 1.1 Actualizar el contador de notificaciones no leídas mediante `NotificationsCubit` cuando `NavigationPage` reciba `notification.received`, conservando el comportamiento actual del aviso.
- [x] 1.2 Eliminar de `SocketService` la solicitud descartada del contador de no leídas para que el servicio de sockets solo entregue eventos del canal.

## 2. Verificar el comportamiento en tiempo real del indicador

- [x] 2.1 Añadir o actualizar pruebas que verifiquen que un evento de notificación solicita un contador actualizado y que, si la solicitud tiene éxito, se actualiza el estado de no leídas.
- [x] 2.2 Verificar que una actualización fallida del contador emite el estado de error existente y que la carga inicial del indicador sigue solicitando y mostrando el contador.
