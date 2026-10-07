## Contexto

La aplicación ya ofrece temas claro y oscuro mediante `AppThemes.themeModeNotifier`, pero inicializa siempre en oscuro y no guarda la preferencia. `SettingsPage` cambia el tema en memoria. A su vez, colores calculados manualmente en widgets no necesariamente reconstruyen cuando cambia el tema, y `main.dart` fija el brillo de los iconos de la barra de estado en oscuro.

La caja de configuración de Hive ya se abre antes de `runApp`, por lo que la preferencia puede cargarse sin incorporar una dependencia nueva ni mostrar primero un tema incorrecto.

## Objetivos y exclusiones

**Objetivos:**

- Restaurar al inicio la última selección claro/oscuro y conservar el modo oscuro como predeterminado en una instalación sin preferencia guardada.
- Mantener sincronizados el tema global, el selector de Ajustes, los colores de las pantallas y el brillo de los iconos del sistema al cambiar de modo.
- Revisar superficies, texto, iconos y controles de las pantallas para corregir colores fijos o contrastes insuficientes.

**Fuera de alcance:**

- Agregar una tercera opción que siga la apariencia del sistema operativo.
- Rediseñar la identidad visual, cambiar los colores de marca o modificar la estructura de navegación.
- Cambiar los datos del usuario o servicios de backend.

## Decisiones

- **Guardar la preferencia en la caja de configuración Hive existente.** La caja se inicializa antes de construir la app; cargar el modo antes de `runApp` evita un destello del tema predeterminado. Se conserva oscuro como valor para instalaciones nuevas. Como alternativa, se podría agregar otro paquete de preferencias, pero no es necesario para una sola opción local.
- **Mantener `ThemeMode` como fuente de verdad.** El control de Ajustes, `MaterialApp.router` y los estilos de las barras del sistema derivarán del mismo valor observable. Esto evita mantener indicadores locales divergentes o asignar brillo fijo a los iconos del sistema.
- **Usar los temas y el `ColorScheme` para componentes y superficies, reservando colores explícitos para estados semánticos y marca.** Se revisarán las vistas y widgets que consultan manualmente el valor actual del tema para garantizar que reconstruyan al alternar. Frente a reemplazar todos los colores de marca, esta opción corrige contrastes sin cambiar la identidad visual.
- **Verificar contraste para texto e indicadores interactivos.** El texto normal alcanzará 4.5:1 y el texto grande, iconos y límites visuales de controles relevantes alcanzarán 3:1 frente a sus superficies.

## Riesgos y compensaciones

- **La corrección puede requerir ajustes en varias pantallas y widgets compartidos.** Se revisará el recorrido de pantallas y componentes reutilizables, priorizando colores de texto, superficies y controles que no se distingan en tema oscuro.
- **El cambio de colores puede alterar vistas que hoy dependen de valores de marca explícitos.** Se mantendrán los colores de marca cuando cumplan el contraste especificado y se cambiarán solo los que no lo cumplan.
- **Las barras del sistema tienen diferencias de representación por plataforma.** Se actualizarán desde el tema activo mediante las APIs de Flutter y se comprobarán en ambos modos donde el entorno de pruebas lo permita.

## Plan de migración

No hay migración remota. Si no existe un valor guardado, la app inicia en modo oscuro como hasta ahora; la selección se guarda cuando el usuario cambia el selector. Revertir el cambio restaura el comportamiento anterior y deja ignorada la preferencia almacenada.

## Preguntas abiertas

Ninguna. Se mantiene el selector binario actual y se usa la preferencia local existente de configuración.
