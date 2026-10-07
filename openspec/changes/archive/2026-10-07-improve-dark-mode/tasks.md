## 1. Persistir y restaurar el modo seleccionado

- [x] 1.1 Añadir una clave tipada para el modo de tema a la configuración local existente y cargarla antes de `runApp`, conservando el modo oscuro como valor predeterminado si no hay preferencia guardada.
- [x] 1.2 Guardar cada cambio del selector de Ajustes y verificar que el control y `MaterialApp.router` reflejan inmediatamente el mismo modo.

## 2. Corregir la presentación en ambos temas

- [x] 2.1 Adaptar el brillo de los iconos de las barras de estado y navegación al tema activo, actualizándolo al alternar entre modos.
- [x] 2.2 Revisar los colores de tema, pantallas y widgets dependientes del modo; corregir colores fijos que causen contraste insuficiente sin alterar innecesariamente los colores de marca.

## 3. Verificar persistencia, actualización y contraste

- [x] 3.1 Añadir pruebas para el modo predeterminado, restauración de preferencia y actualización inmediata del selector y tema activo.
- [x] 3.2 Verificar texto normal con contraste mínimo de 4.5:1 y texto grande, iconos y límites de controles relevantes con mínimo de 3:1 en los temas claro y oscuro.
- [x] 3.3 Ejecutar análisis estático y pruebas focalizadas para la configuración del tema y los componentes revisados.
