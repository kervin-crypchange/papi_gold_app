## Why

La aplicación ofrece un selector entre tema claro y oscuro, pero la elección solo vive en memoria y vuelve al valor predeterminado oscuro al reiniciarse. Además, hay colores elegidos manualmente en varias vistas y el brillo de los iconos de las barras del sistema está fijo, lo que puede producir contrastes incoherentes al cambiar de tema.

## What Changes

- Guardar la selección actual de tema y restaurarla al iniciar la aplicación, manteniendo el tema oscuro como valor predeterminado cuando todavía no exista una preferencia guardada.
- Revisar y corregir los colores de superficies, textos, iconos y componentes de las pantallas para que respeten el tema seleccionado y mantengan un contraste legible.
- Ajustar el brillo de los iconos de las barras del sistema al tema activo.
- Mantener el selector actual de tema claro/oscuro; no agregar una opción de seguimiento del tema del sistema.

## Capabilities

### New Capabilities

- `dark-mode`: Persistir la selección claro/oscuro y mantener una presentación legible y coherente al cambiar entre temas.

### Modified Capabilities

## Impact

- Afecta la inicialización de la aplicación, `AppThemes`, `SettingsPage`, los colores compartidos y las pantallas y componentes con colores dependientes del tema.
- Reutiliza el almacenamiento local existente; no se prevén cambios en API ni dependencias.
