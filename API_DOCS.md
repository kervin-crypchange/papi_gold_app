# Documentación de la API Headless - Papi Gold

Esta documentación detalla el uso, funcionamiento y estructura de la API Headless de Papi Gold. Todos los endpoints devuelven respuestas en formato JSON.

---

## 1. Utilidades y Salud

### 1.1 Health Check (Estado del Servidor)
Permite monitorear la salud del servidor y la conexión a la base de datos de forma pública.
- **URL:** `GET /api/health`
- **Respuesta (200 OK):**
```json
{
  "status": "ok",
  "db_status": "ok",
  "timestamp": "2026-06-10T14:30:00.000000Z"
}
```

### 1.2 Webhook de Stripe
Punto de entrada para que Stripe notifique cambios de estado en los pagos de forma asíncrona. 
- **URL:** `POST /api/stripe/webhook`
- **Seguridad:** Requiere validación de firma mediante el header `Stripe-Signature` (Middleware `StripeSignature`).
- **Eventos Procesados:**
  - `payment_intent.succeeded`: El pago se completó exitosamente. Actualiza la venta a **Aprobado**, reduce el stock aloof e incrementa el stock de venta real.
  - `payment_intent.payment_failed`: El pago falló. Actualiza el estado a **Fallido**.
  - `payment_intent.processing`, `payment_intent.canceled`, `payment_intent.requires_action`.
  - `charge.refunded`: El cargo fue reembolsado. Actualiza el estado a **Reintegrado**.
- **Ejemplo de Cuerpo (Payload de Stripe):**
```json
{
  "id": "evt_1P...",
  "type": "payment_intent.succeeded",
  "data": {
    "object": {
      "id": "pi_3P...",
      "amount": 125050,
      "currency": "usd",
      "status": "succeeded",
      "metadata": { "order_id": "ORD-123" }
    }
  }
}
```

---

## 2. Arquitectura y Seguridad

La API utiliza capas de seguridad obligatorias para proteger los datos y asegurar que solo las aplicaciones autorizadas interactúen con ella.

### 1.1 App Key (Header X-API-Key)
Requerido para **todas** las peticiones públicas (bajo el middleware `app_key`).
- **Header:** `X-API-Key`
- **Valor:** Definido en el entorno del servidor (ej. `base64:vI6...`)

### 1.2 Autenticación Sanctum (Bearer Token)
Requerido para endpoints del área privada del cliente. Los tokens emitidos pueden tener alcances (scopes):
- `full-access`: Permite realizar acciones críticas como cambiar la contraseña.
- **Header:** `Authorization: Bearer {token}`

### 1.3 Sistema de Traducciones
La mayoría de los recursos devuelven un campo `translations` que contiene las versiones localizadas de los campos descriptivos.
- **Formato:** Objeto con códigos de idioma (ISO 639-1) como llaves.
- **Ejemplo:**
```json
"translations": {
  "en": { "name": "Gold Ring", "description": "Beautiful ring..." },
  "es": { "name": "Anillo de Oro", "description": "Hermoso anillo..." }
}
```

---

## 3. Catálogo de Productos (Públicos)

### 2.1 Listar Productos
- **URL:** `GET /api/product`
- **Respuesta:** Lista paginada agrupada por tipo de metal.
```json
{
  "data": [
    {
      "id": 1,
      "name": "Oro",
      "products": [
        {
          "id": 10,
          "name": "Anillo Clásico",
          "description": "Anillo de oro con acabado pulido.",
          "stock": 5,
          "imagen": "https://api.papi.gold/storage/products/anillo.jpg",
          "price": 1250.50,
          "category": { 
            "id": 1, "name": "Anillos", "description": "...", "color": "#FFD700",
            "translations": { "en": { "name": "Rings" } } 
          },
          "translations": { "en": { "name": "Classic Ring" } }
        }
      ],
      "translations": {"en": { "name": "Gold" } }
    }
  ],
  "meta": { "current_page": 1, "last_page": 5, "per_page": 4, "total": 20 }
}
```

### 2.2 Ver Producto Detallado
- **URL:** `GET /api/product/{id}`
- **Respuesta:** Objeto `ProductResource`.
```json
{
  "data": {
    "id": 10,
    "name": "Anillo Clásico",
    "description": "Anillo de oro...",
    "stock": 5,
    "imagen": "...",
    "price": 1250.50,
    "category": { "id": 1, "name": "Anillos", ... },
    "translations": { ... }
  }
}
```

---

## 4. Precios de Metales (Públicos)

### 3.1 Listar Precios Actuales
- **URL:** `GET /api/price`
- **Respuesta:** Análisis completo de metales activos. El campo `categories` contiene la representación minimalista de los productos de ese metal.
```json
{
  "success": true,
  "data": [
    {
      "symbol": "XAU",
      "name": "Oro",
      "price": 65.45,
      "conversion": 31.1034768,
      "price_history": 64.90,
      "is_stale": false,
      "last_updated": "2026-06-10 14:30:00",
      "carats": [
        { 
          "id": 1, "name": "18K", "purity": 0.75, "law": "750", 
          "status": "Activo", "translations": { "en": { "name": "18K" } } 
        }
      ],
      "categories": [
        { 
          "id": 10, "name": "Anillo Clásico", "stock": 5, "price": 1250.50,
          "translations": { "en": { "name": "Classic Ring" } } 
        }
      ],
      "translations": {"en": { "name": "Gold" } }
    }
  ]
}
```

### 3.2 Historial y Detalle por Metal
- **URL:** `GET /api/price/{symbol}`
- **Ejemplo:** `/api/price/XAU`
- **Nota:** La respuesta devuelve un **array** dentro del campo `data`.
```json
{
  "success": true,
  "data": [
    {
      "symbol": "XAU",
      "name": "Oro",
      "price": 65.45,
      "carats": [ ... ],
      "categories": [ ... ],
      "translations": { ... }
    }
  ]
}
```

---

## 5. Ubicaciones (Públicos)

### 4.1 Listar Países
Obtiene la lista de países configurados como activos en el sistema.
- **URL:** `GET /api/location`
- **Respuesta (200 OK):**
```json
{
  "data": [
    {
      "id": 1,
      "name": "Venezuela",
      "iso2": "VE",
      "phone_code": "58",
      "emoji": "🇻🇪"
    },
    {
      "id": 2,
      "name": "United States",
      "iso2": "US",
      "phone_code": "1",
      "emoji": "🇺🇸"
    }
  ]
}
```

### 4.2 Ver Estados o Ciudades
Filtra ubicaciones geográficas de forma jerárquica.
- **URL:** `GET /api/location/show`
- **Query Params:**
  - `?country={id}`: Devuelve la lista de estados de un país.
  - `?country={id}&state={id}`: Devuelve la lista de ciudades de un estado.
- **Respuesta Estados (200 OK):**
```json
{
  "data": [
    { "id": 10, "name": "Distrito Capital", "country_id": 1 }
  ]
}
```
- **Respuesta Ciudades (200 OK):**
```json
{
  "data": [
    { "id": 50, "name": "Caracas", "state_id": 10, "country_id": 1 }
  ]
}
```
- **Errores:**
  - `400 Bad Request`: Si no se envían parámetros o la combinación es inválida.
  - `404 Not Found`: Si el país o estado solicitado no existe.

---

## 6. Autenticación y Sesión

### 5.1 Magic Link (Acceso Temporal)
Permite el acceso a clientes que no tienen una contraseña establecida o que prefieren entrar vía enlace de correo.
1. **Solicitar (`POST /api/request-access`):**
   - **Cuerpo:**
   ```json
   { 
     "email": "juan@papi.com", 
     "invoice_number": "PG-5521" 
   }
   ```
   - **Validación:** El `invoice_number` debe pertenecer al cliente con ese `email`.
   - **Respuesta (200 OK):** `{"message": "Enlace enviado exitosamente."}`
   - **Errores:** `422` (Si el cliente tiene contraseña establecida o datos incorrectos).

2. **Verificación (`GET /api/request-access/verify`):** Endpoint interno que verifica la firma y redirige al frontend:
   - Éxito: `{frontend_url}/verify-access?token={token}&sale_id={invoice_number}`
   - Error: `{frontend_url}/verify-access?error=expired|invalid`

### 5.2 Login (Sesión por Contraseña)
Autenticación tradicional para clientes con contraseña establecida.
- **URL:** `POST /api/session`
- **Petición:** `{ "email": "usuario@papi.com", "password": "..." }`
- **Respuesta (200 OK):**
```json
{
  "token": "1|ABC...",
  "client": {
    "id": 5, "name": "Juan", "lastname": "Pérez", "email": "usuario@papi.com"
  },
  "message": "Inicio de sesión exitoso."
}
```
- **Respuestas de Error:**
  - `403 Forbidden`: `{ "message": "...", "requires_verification": true }` (Email no verificado).
  - `422 Unprocessable Content`: `{ "message": "Las credenciales... son incorrectas." }`

### 5.3 Logout
Cierra la sesión actual revocando el token Bearer.
- **URL:** `DELETE /api/session` (Requiere Token Bearer).
- **Respuesta (200 OK):** `{ "message": "Sesión cerrada correctamente." }`

---

## 7. Proceso de Checkout y Pagos

### 6.1 Crear Orden (Checkout)
- **URL:** `POST /api/order`
- **Cuerpo de Petición:**
```json
{
  "clientData": {
    "name": "Juan", 
    "lastname": "Pérez", 
    "email": "juan@papi.com", 
    "phone": "+1234567890", 
    "country": 1, 
    "state": 10, 
    "city": 50,
    "address1": "Av. Principal 123", 
    "address2": "Edif. Centro",
    "code_zip": "1010", 
    "receive_advertise": true
  },
  "cartItems": [
    { 
      "id": 10, 
      "quantity": 1, 
      "price": 1250.50, 
      "format": 1 
    }
  ],
  "confirm_existing_client": false
}
```
- **Validaciones Principales:**
  - `clientData.email`: Único en el sistema. Si existe, requiere `confirm_existing_client: true` para proceder.
  - `cartItems.*.quantity`: No puede exceder el stock disponible real (`stock - aloof`).
  - `cartItems.*.price`: Si el precio del producto subió en el servidor durante el proceso, devuelve error `409 price_changed`.
  - `format`: 1 para Compra, 0 para Empeño (Inversión).
- **Respuesta Éxito (201 Created):**
```json
{
  "message": "Orden creada exitosamente",
  "sale": { 
    "order": "ORD-123", 
    "invoice_number": "PG-5521", 
    "total_v": 1250.50 
  },
  "items": [ 
    { "id": 1, "product": "Anillo Clásico", "quantity": 1, "price": 1250.50, "type": "Compra" } 
  ],
  "clientSecret": "pi_...", 
  "paymentId": "pay_..."
}
```
- **Flujo Alternativo (Éxito con error en Pasarela):** Si la orden se crea pero Stripe falla, devuelve `201 Created` con `payment_error` y el código de la orden para reintento posterior.

### 6.2 Refrescar Intento de Pago
Permite generar una nueva intención de pago para una orden existente.
- **URL:** `POST /api/payment`
- **Cuerpo (Stripe):** `{ "sale_id": "ORD-123" }`
- **Cuerpo (Manual/Otro):** `{ "sale_id": 99, "pay_method_id": 1, "pay_amount": 1250.50 }`
- **Respuesta Stripe (200 OK):**
```json
{
  "clientSecret": "pi_...",
  "paymentId": "pay_..."
}
```

---

## 8. Área Privada (Requiere Token)

### 8.1 Perfil del Cliente
- **URL:** `GET /api/client/me` (Se identifica al usuario por su Bearer Token, ignorando el ID numérico).
- **Respuesta (200 OK):**
```json
{
  "data": {
    "id": 5, 
    "name": "Juan", 
    "lastname": "Pérez", 
    "email": "juan@papi.com",
    "country": { "id": 1, "name": "Venezuela" },
    "state": { "id": 10, "name": "Distrito Capital" },
    "city": { "id": 50, "name": "Caracas" },
    "address1": "Av. Principal", 
    "address2": "Edif. Centro", 
    "code_zip": "1010", 
    "phone": "+58412...",
    "password": true, 
    "receive_advertise": false
  }
}
```

### 8.2 Actualizar / Establecer Contraseña
Permite al cliente establecer su contraseña por primera vez o actualizarla.
- **URL:** `PUT /api/client/me`
- **Seguridad:** Requiere Bearer Token con scope `full-access`.
- **Cuerpo:**
```json
{
  "password": "nueva_contraseña_123",
  "password_confirmation": "nueva_contraseña_123"
}
```
- **Respuesta (200 OK):**
```json
{
  "message": "Contraseña establecida exitosamente...",
  "client": { "id": 5, "name": "Juan", ... }
}
```

### 8.3 Historial de Órdenes
- **URL:** `GET /api/order`
- **Respuesta (200 OK):** Lista paginada que incluye estadísticas globales (`invested`, `sold`) del cliente.

### 8.4 Ver Detalle de una Orden
Obtiene la información detallada de una orden específica.
- **URL:** `GET /api/order/{order_code}`
- **Parámetro:** El `{order_code}` es el identificador único de la orden (ej. `ORD-123`), **no** su ID numérico.
- **Respuesta:**
```json
{
  "data": {
    "id": 99,
    "order": "ORD-123",
    "invoice_number": "PG-5521",
    "description": "Compra de joyería",
    "total_v": 1250.50,
    "total_pago_v": 1250.50,
    "status": { "id": 1, "name": "Pagado", "translations": { ... } },
    "items": [
      {
        "id": 1, "product": "Anillo Clásico", "quantity": 1, "price": 1250.50, 
        "total": 1250.50, "image": "https://...", "type": "Compra",
        "translations": { ... }
      }
    ],
    "payments": [
      {
        "id": 50, "amount": 1250.50, "reference": "pi_...", "type": "Compra",
        "status": { "id": 1, "name": "Aprobado", "translations": { ... } },
        "method": { "id": 10, "name": "Stripe", "description": "card" }
      }
    ],
    "shipping": [
      {
        "id": 10, "tracking_number": "1Z999...", 
        "courier": { "id": 5, "name": "UPS" },
        "status": { "id": 3, "name": "Entregado" }
      }
    ],
    "translations": { ... }
  }
}
```

---

## 9. Soporte y Configuración

### 9.1 Chat
- **Enviar Mensaje (`POST /api/chat`):** Envío de mensajes y archivos (Multipart/Form-Data).
  - **Campos:** 
    - `identifier` (req): ID único de sesión/chat.
    - `message` (req_without:file): Texto del mensaje.
    - `file` (opcional): Imagen (jpg, png, webp, max 10MB).
    - `name`, `email`, `phone`, `order_id` (opcionales): Para identificar al cliente o asociar a una orden.
  - **Respuesta (201 Created):**
  ```json
  {
    "success": true,
    "data": { "id": 1, "message": "Hola...", "file_url": null, "is_operator": false, "created_at": "..." }
  }
  ```

- **Ver Historial (`GET /api/chat/{identifier}`):**
  - **Respuesta (200 OK):**
  ```json
  {
    "success": true,
    "data": {
      "id": 10, "identifier": "session_xxx", "name": "Cliente",
      "messages": [ { "id": 1, "message": "Hola...", "is_operator": false } ]
    }
  }
  ```

### 9.2 Formulario de Contacto (Consulta)
- **URL:** `POST /api/consultation`
- **Cuerpo:** 
```json
{ 
  "name": "Juan", 
  "email": "juan@papi.com", 
  "phone": "584120000000", 
  "type": "Compra de Oro", 
  "details": "Deseo información sobre..." 
}
```
- **Respuesta (201 Created):** `{ "message": "Consulta enviada exitosamente." }`

### 9.3 Ajustes Globales
Obtiene configuraciones públicas dinámicas del sitio.
- **URL:** `GET /api/settings`
- **Respuesta (200 OK):**
```json
{
  "success": true,
  "data": { 
    "site_name": "Papi Gold", 
    "currency": "USD", 
    "contact_email": "soporte@papi.gold",
    "social_links": { "instagram": "..." }
  }
}
```

---

## 10. Manejo de Errores

| Código | Código de Error (`code`) | Descripción |
| :--- | :--- | :--- |
| `409` | `price_changed` | El precio subió durante el proceso. |
| `409` | `client_exists_confirmation_required` | El cliente ya existe, requiere `confirm_existing_client: true`. |
| `422` | `insufficient_stock` | Stock insuficiente disponible. |
| `422` | (Validación) | Errores de validación en el campo `errors`. |

### Ejemplo de Error de Validación (422)
```json
{
  "message": "Los datos proporcionados no son válidos.",
  "errors": {
    "email": ["El formato del correo es inválido."],
    "phone": ["El número de teléfono ya está registrado."]
  }
}
```
