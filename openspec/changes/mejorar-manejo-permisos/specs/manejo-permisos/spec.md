## ADDED Requirements

### Requirement: El arranque no solicita permisos opcionales
La aplicación MUST permitir el inicio y la navegación inicial sin solicitar en bloque permisos de cámara, fotos, ubicación o notificaciones.

#### Scenario: Inicio sin permisos concedidos
- **WHEN** la aplicación se inicia y uno o más permisos opcionales no están concedidos
- **THEN** la aplicación muestra su interfaz inicial sin solicitar esos permisos en bloque ni fallar por su ausencia

### Requirement: Los permisos se solicitan en el contexto de uso
Antes de acceder a una capacidad protegida, la aplicación MUST consultar y, cuando corresponda, solicitar el permiso necesario, y MUST actuar según el estado resultante. MUST ofrecer una explicación y acceso a Ajustes para un permiso denegado permanentemente; MUST permitir continuar sin la función protegida cuando sea opcional.

#### Scenario: Permiso solicitado para una función
- **WHEN** el usuario inicia una función que requiere un permiso no concedido
- **THEN** la aplicación solicita ese permiso en el contexto de la función y no accede a la capacidad hasta conocer el resultado

#### Scenario: Permiso denegado permanentemente
- **WHEN** el sistema informa que el permiso está denegado permanentemente o restringido
- **THEN** la aplicación explica la limitación, ofrece acceso a Ajustes y no repite una solicitud que el sistema ya no puede mostrar

#### Scenario: Función opcional sin permiso
- **WHEN** el usuario deniega un permiso requerido por una función opcional
- **THEN** la aplicación mantiene disponibles las demás funciones y presenta una alternativa o informa que esa función no está disponible

### Requirement: El estado del permiso conserva el detalle de la plataforma
La capa de permisos MUST exponer los estados reportados por el sistema sin reducirlos a un booleano que confunda concesión, denegación, restricción o acceso limitado.

#### Scenario: Consulta de estado
- **WHEN** un consumidor consulta un permiso
- **THEN** recibe un estado distinguible que permite decidir si usar la capacidad, solicitar permiso, mostrar una explicación o dirigir al usuario a Ajustes

### Requirement: La ubicación no es requisito para iniciar ni usar el mapa
La aplicación MUST gestionar la ubicación del dispositivo como opcional y MUST evitar acceder a una posición no inicializada. El selector de direcciones MUST permitir la selección manual sin permiso y solicitar ubicación solo después de que el usuario active la acción «Mi ubicación». Si no hay una posición disponible por permiso denegado, servicio desactivado o error de adquisición, la aplicación MUST mantener accesible el mapa centrado en el último punto elegido localmente o, si no existe, en un centro neutral con zoom amplio.

#### Scenario: Apertura del selector sin pedir ubicación
- **WHEN** el usuario abre el selector de direcciones sin una posición disponible
- **THEN** el mapa se muestra centrado en el último punto elegido localmente o en el centro neutral si no hay un punto guardado, sin solicitar permiso

#### Scenario: Ubicación concedida desde la acción explícita
- **WHEN** el usuario activa «Mi ubicación» y concede el permiso con el servicio disponible
- **THEN** la aplicación obtiene y centra el mapa en la posición mediante un único flujo de ubicación

#### Scenario: Ubicación denegada o servicio desactivado
- **WHEN** el usuario deniega la ubicación, el servicio está desactivado o no se puede obtener una posición después de activar «Mi ubicación»
- **THEN** la posición se representa como no disponible, el mapa permanece utilizable y muestra el último punto elegido o el centro neutral sin fallar

#### Scenario: Guardar último punto elegido
- **WHEN** el usuario selecciona un punto en el mapa
- **THEN** la aplicación guarda localmente sus coordenadas y las reutiliza como centro inicial la próxima vez que abra el selector

#### Scenario: Ubicación solicitada desde más de una pantalla
- **WHEN** varios consumidores necesitan conocer o solicitar ubicación
- **THEN** utilizan el mismo servicio de ubicación y no ejecutan solicitudes duplicadas mediante mecanismos distintos

### Requirement: Ajustes refleja el estado actual de permisos
La pantalla de Ajustes MUST mostrar el estado actual de los permisos del sistema que presenta y MUST volver a consultarlo al regresar desde la configuración del sistema. Las notificaciones dentro de la app MUST seguir disponibles sin depender del permiso de notificaciones del sistema.

#### Scenario: Apertura de Ajustes
- **WHEN** el usuario abre la pantalla de Ajustes
- **THEN** los indicadores de permisos se basan en estados consultados al sistema y no en valores predeterminados u obsoletos

#### Scenario: Regreso desde configuración del sistema
- **WHEN** el usuario vuelve a la aplicación después de cambiar permisos en la configuración del sistema
- **THEN** Ajustes actualiza sus indicadores usando una nueva consulta del sistema

#### Scenario: Notificaciones de la aplicación
- **WHEN** el usuario accede a las notificaciones desde Ajustes
- **THEN** la aplicación abre la lista interna de notificaciones sin solicitar permiso de notificaciones del sistema

### Requirement: Las declaraciones de plataforma corresponden a funciones utilizadas
La aplicación MUST declarar los permisos y textos de privacidad requeridos por sus capacidades implementadas en Android e iOS, y MUST NOT solicitar ni declarar permisos de capacidades sin consumidor funcional, salvo que una obligación de la plataforma lo requiera. Mientras no existan consumidores funcionales de cámara, fotos o notificaciones del sistema, la aplicación MUST NOT solicitar esos permisos.

#### Scenario: Capacidad implementada en una plataforma
- **WHEN** una función de la aplicación requiere un permiso del sistema en Android o iOS
- **THEN** la configuración nativa contiene la declaración o texto de privacidad requerido para esa función

#### Scenario: Permiso sin consumidor funcional
- **WHEN** no existe una función implementada que necesite un permiso
- **THEN** la aplicación no lo solicita en el arranque ni lo conserva en la configuración nativa como acceso innecesario
