## ADDED Requirements

### Requirement: Actualizar el contador de notificaciones no leídas al recibir un evento websocket
La aplicación SHALL actualizar el contador de notificaciones no leídas cuando reciba un evento `notification.received` en el canal privado autenticado de notificaciones y SHALL publicar el contador actualizado mediante el estado de notificaciones que observa el indicador de navegación.

#### Scenario: El evento de notificación actualiza el indicador de navegación
- **WHEN** el canal privado autenticado de notificaciones entrega un evento `notification.received`
- **THEN** la aplicación solicita el contador actual de notificaciones no leídas y actualiza `UnreadCountWidget` si la solicitud tiene éxito

#### Scenario: Se conserva el aviso de notificación
- **WHEN** el canal privado autenticado de notificaciones entrega un evento `notification.received`
- **THEN** se sigue mostrando el aviso existente del evento mientras se actualiza el contador de notificaciones no leídas

#### Scenario: Falla la actualización del contador
- **WHEN** falla la solicitud del contador de no leídas iniciada por un evento de notificación
- **THEN** la aplicación publica el estado de error existente para el contador de no leídas, en lugar de tratar la actualización como exitosa

### Requirement: Cargar el contador de no leídas al inicializar el indicador
La aplicación SHALL seguir solicitando el contador de notificaciones no leídas cuando se inicialice `UnreadCountWidget`.

#### Scenario: El indicador se inicializa con el contador de no leídas
- **WHEN** se inicializa `UnreadCountWidget` y la solicitud del contador tiene éxito
- **THEN** el widget muestra el contador devuelto por el servidor
