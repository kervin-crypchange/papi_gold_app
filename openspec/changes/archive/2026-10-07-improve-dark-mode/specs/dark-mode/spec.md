## ADDED Requirements

### Requirement: Persistir y restaurar la selección del tema
La aplicación SHALL ofrecer los modos claro y oscuro, SHALL aplicar inmediatamente la selección realizada en Ajustes y SHALL guardar esa selección para restaurarla en los siguientes inicios. Si no existe una preferencia guardada, la aplicación SHALL iniciar en modo oscuro.

#### Scenario: La primera ejecución usa el tema oscuro
- **WHEN** la aplicación se inicia sin una preferencia de tema guardada
- **THEN** aplica el modo oscuro y el selector de Ajustes lo muestra como activo

#### Scenario: La selección se conserva después de reiniciar
- **WHEN** el usuario cambia el tema en Ajustes y luego reinicia la aplicación
- **THEN** la aplicación restaura el último modo seleccionado antes de mostrar su interfaz principal

#### Scenario: Cambiar el tema actualiza la interfaz de inmediato
- **WHEN** el usuario cambia el selector entre modo claro y modo oscuro
- **THEN** la aplicación actualiza el tema de la interfaz y el valor mostrado por el selector sin reiniciar

### Requirement: Mantener legibilidad y contraste en ambos temas
La aplicación SHALL presentar texto, superficies, iconos e indicadores de controles con colores apropiados para el tema activo. El texto normal SHALL alcanzar una relación de contraste mínima de 4.5:1; el texto grande, los iconos y los límites visuales de controles relevantes SHALL alcanzar una relación mínima de 3:1 frente a su superficie.

#### Scenario: Las pantallas son legibles en modo oscuro
- **WHEN** el modo oscuro está activo y se muestra cualquier pantalla de la aplicación
- **THEN** el texto, las superficies y los elementos interactivos mantienen los contrastes mínimos requeridos y ningún componente conserva un color fijo que lo vuelva ilegible

#### Scenario: Los componentes se actualizan al cambiar de tema
- **WHEN** el usuario alterna entre el modo oscuro y el claro mientras una pantalla está visible
- **THEN** los colores de los componentes dependientes del tema se reconstruyen con la paleta del nuevo modo

### Requirement: Adaptar los iconos de las barras del sistema al tema
La aplicación SHALL ajustar el brillo de los iconos de la barra de estado y de navegación al tema activo para que se distingan de las superficies detrás de ellos.

#### Scenario: Las barras del sistema siguen el tema oscuro
- **WHEN** el modo oscuro está activo
- **THEN** los iconos de las barras del sistema usan un brillo legible sobre las superficies del modo oscuro

#### Scenario: Las barras del sistema siguen el tema claro
- **WHEN** el modo claro está activo
- **THEN** los iconos de las barras del sistema usan un brillo legible sobre las superficies del modo claro
