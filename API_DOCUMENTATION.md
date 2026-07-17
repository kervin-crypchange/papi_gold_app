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

- **Respuesta de la API (Lo que Stripe recibe):**
La API responde con un `200 OK` tras validar la firma y procesar el evento.
```json
{
  "status": "success",
  "message": "Webhook processed: payment_intent.succeeded"
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

### 1.4 Actualizaciones en Tiempo Real (WebSockets)
La API utiliza **Laravel Reverb** para notificar cambios en los datos de forma inmediata. Las aplicaciones clientes pueden suscribirse a estos canales utilizando **Laravel Echo**.

#### Configuración de Conexión
- **Protocolo:** `ws` / `wss`
- **Host:** Definido en el entorno (ej. `api.papi.gold`)
- **Puerto:** `80` / `443`

#### Canales y Eventos Disponibles

| Canal | Evento | Descripción |
| :--- | :--- | :--- |
| `prices` | `prices.updated` | Se dispara cuando cambian los precios internacionales de los metales. |
| `products` | `product.updated` | Se dispara cuando se modifica un producto, su stock o su precio. |
| `settings` | `settings.updated` | Se dispara cuando cambian los ajustes globales del sitio. |
| `chat.{identifier}` | `message.sent` | Canal privado/presencia para el chat de soporte (requiere identificador de sesión). |
| `client.{id}` | `notification.received` | **Canal Privado**: Se dispara cuando el cliente recibe una nueva notificación de sistema. |
| `client.{id}` | `sale.updated` | **Canal Privado**: Se dispara cuando un pedido del cliente cambia de estado o datos. |

#### Ejemplo de Suscripción (JavaScript/Laravel Echo)
```javascript
import Echo from 'laravel-echo';

const echo = new Echo({
  broadcaster: 'reverb',
  key: 'TU_REVERB_KEY',
  wsHost: 'api.papi.gold',
  wsPort: 443,
  forceTLS: true,
  enabledTransports: ['ws', 'wss'],
});

// Escuchar cambios en precios
echo.channel('prices')
  .listen('.prices.updated', (data) => {
    console.log('Precios actualizados:', data.prices);
  });

// Escuchar cambios en productos
echo.channel('products')
  .listen('.product.updated', (data) => {
    console.log(`Producto ${data.productId} ${data.action}`, data.product);
  });
```

---

## 3. Catálogo de Productos (Públicos)

### 2.1 Listar Productos
- **URL:** `GET /api/product`
- **Query Params:**
  - `?per_page={n}` (opcional): Cantidad de elementos por página (default: 4).
  - `?metal={id}` (opcional): Filtrar por ID de tipo de metal.
  - `?category={id}` (opcional): Filtrar por ID de categoría de producto.
- **Respuesta:** Lista paginada agrupada por tipo de metal, incluyendo metadatos inteligentes de filtros disponibles. Los filtros están jerárquicamente vinculados (Metal -> Categorías). Sigue la estructura estándar de paginación (`data`, `links`, `meta`).
```json
{
  "data": [ ... ],
  "links": {
    "first": "http://api.papi.gold/api/product?page=1",
    "last": "http://api.papi.gold/api/product?page=5",
    "prev": null,
    "next": "http://api.papi.gold/api/product?page=2"
  },
  "meta": {
    "current_page": 1,
    "from": 1,
    "last_page": 5,
    "path": "http://api.papi.gold/api/product",
    "per_page": 4,
    "to": 4,
    "total": 20
  },
  "filters": {
    "metal_types": [
      { 
        "id": 1, 
        "name": "Oro", 
        "has_products": true,
        "has_categories": true,
        "categories": [
           { 
             "id": 5, 
             "name": "Anillos", 
             "has_products": true, 
             "translations": { "es": { "categ_name": "Anillos" }, "en": { "categ_name": "Rings" } } 
           }
        ],
        "translations": { "es": { "name": "Oro" }, "en": { "name": "Gold" } } 
      }
    ]
  }
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

### 2.3 Eventos en Tiempo Real (WebSockets)
El sistema emite actualizaciones instantáneas cuando un producto es creado, modificado o eliminado.
- **Canal Público:** `products`
- **Evento:** `product.updated`
- **Data Recibida (Payload):**
```json
{
  "productId": 10,
  "action": "updated",
  "product": {
    "id": 10,
    "name": "Anillo Clásico",
    "description": "Anillo de oro...",
    "stock": 5,
    "imagen": "...",
    "price": 1250.50,
    "category": { "id": 1, "name": "Anillos" },
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
- **Nota:** La respuesta devuelve un **array** dentro del campo `data` con la misma estructura normalizada que el listado general.
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

### 3.3 Eventos en Tiempo Real (WebSockets)
Actualización automática de precios internacionales de metales.
- **Canal Público:** `prices`
- **Evento:** `prices.updated`
- **Data Recibida (Payload):**
```json
{
  "prices": [
    {
      "symbol": "XAU",
      "name": "Oro",
      "price": 65.45,
      "last_updated": "2026-06-10 14:30:00"
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
    "id": 5,
    "name": "Juan",
    "lastname": "Pérez",
    "email": "usuario@papi.com"
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

### 5.4 Registro de Clientes
Permite registrar un nuevo cliente en el sistema.
- **URL:** `POST /api/register`
- **Cuerpo:**
```json
{
  "name": "Juan",
  "lastname": "Pérez",
  "email": "juan@papi.com",
  "phone": "+584120000000",
  "country": 1,
  "state": 10,
  "city": 50,
  "address1": "Av. Principal 123",
  "address2": "Edif. Centro",
  "code_zip": "1010",
  "password": "Password123!",
  "password_confirmation": "Password123!"
}
```
- **Validaciones:**
  - `email`: Debe ser único en la tabla `clients`.
  - `phone`: Debe ser único en la tabla `clients`.
  - `country`, `state`, `city`: Deben ser IDs válidos y estar activos.
  - `password`: Mínimo 8 caracteres, debe incluir letras (mayúsculas y minúsculas), números y símbolos.
- **Respuesta (201 Created):**
```json
{
  "message": "¡Registro exitoso! Por favor, verifica tu correo electrónico para activar tu cuenta.",
  "status": "pending_verification"
}
```

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
Obtiene la información del perfil del cliente autenticado.
- **URL:** `GET /api/client/me` (Se identifica al usuario por su Bearer Token).
- **Respuesta (200 OK):**
```json
{
  "data": {
    "id": 5, 
    "name": "Juan", 
    "lastname": "Pérez", 
    "country": { "id": 1, "name": "Venezuela" },
    "state": { "id": 10, "name": "Distrito Capital" },
    "city": { "id": 50, "name": "Caracas" },
    "address1": "Av. Principal", 
    "address2": "Edif. Centro", 
    "code_zip": "1010", 
    "phone": "+58412...",
    "email": "juan@papi.com",
    "receive_advertise": 0,
    "password": true,
    "email_verified": "2026-06-10T14:30:00.000000Z",
    "category": "Minorista"
  }
}
```

### 8.2 Actualizar Datos del Perfil
Permite actualizar la información personal del cliente. No permite cambiar la contraseña directamente por este medio.
- **URL:** `PUT /api/client/{id}`
- **Seguridad:** Requiere Bearer Token. El `{id}` puede ser el ID numérico o la palabra `me`.
- **Nota sobre 2FA:** Si el sistema lo requiere, el middleware/trait enviará un código al correo y devolverá un `422` solicitando el `verification_code`.
- **Cuerpo (Ejemplo):**
```json
{
  "name": "Juan Ignacio",
  "lastname": "Pérez",
  "phone": "+584140000000",
  "country": 1,
  "state": 10,
  "city": 50,
  "address1": "Av. Principal 123",
  "address2": "Edif. Centro",
  "code_zip": "1010",
  "receive_advertise": 1,
  "verification_code": "123456"
}
```
- **Respuesta (200 OK):**
```json
{
  "message": "¡Tus datos han sido actualizados correctamente!",
  "client": {
    "id": 5,
    "name": "Juan Ignacio",
    "lastname": "Pérez",
    "email": "juan@papi.com",
    "country": { "id": 1, "name": "Venezuela" },
    "state": { "id": 10, "name": "Distrito Capital" },
    "city": { "id": 50, "name": "Caracas" },
    "address1": "Av. Principal 123",
    "address2": "Edif. Centro",
    "code_zip": "1010",
    "phone": "+584140000000",
    "receive_advertise": 1,
    "password": true,
    "category": "Minorista"
  }
}
```

### 8.3 Actualizar Contraseña
Endpoint dedicado exclusivamente al cambio de contraseña.
- **URL:** `PUT /api/client/password`
- **Seguridad:** Requiere Bearer Token.
- **Nota sobre 2FA:** Este proceso requiere validación de identidad mediante `verification_code`.
- **Cuerpo:**
```json
{
  "current_password": "mi_password_actual",
  "password": "nueva_contraseña_123",
  "password_confirmation": "nueva_contraseña_123",
  "verification_code": "123456"
}
```
- **Validación:** 
  - `current_password`: Obligatoria si el cliente ya tiene una contraseña establecida.
  - `password`: Mínimo 8 caracteres, debe incluir letras (mayúsculas y minúsculas), números y símbolos.
- **Respuesta (200 OK):**
```json
{
  "message": "Contraseña actualizada exitosamente."
}
```
- **Error (422 Unprocessable Content):**
```json
{
  "message": "Los datos proporcionados no son válidos.",
  "errors": {
    "current_password": ["La contraseña actual no es correcta."],
    "password": ["La contraseña debe tener al menos 8 caracteres."]
  }
}
```

### 8.4 Valuación de Activos (Portafolio)
Obtiene un resumen financiero de las compras del cliente, calculando el costo de adquisición vs el valor de mercado actual según los precios spot.
- **URL:** `GET /api/valuation`
- **Seguridad:** Requiere Bearer Token.
- **Respuesta (200 OK):**
```json
{
  "data": {
    "total": {
      "totalAcquisitionCost": 5250.25,
      "currentMarketValue": 5840.10,
      "totalWeightOz": 2.5412,
      "unrealizedProfitLoss": 589.85,
      "profitPercentage": 11.23,
      "avgPurchasePrice": 2066.05,
      "currentSpotPriceGold": 2350.50,
      "currentSpotPrice": 0
    },
    "metals": [
      {
        "name": "Oro",
        "symbol": "XAU",
        "stats": {
          "totalAcquisitionCost": 5250.25,
          "currentMarketValue": 5840.10,
          "totalWeightOz": 2.5412,
          "unrealizedProfitLoss": 589.85,
          "profitPercentage": 11.23,
          "avgPurchasePrice": 2066.05,
          "currentSpotPriceGold": 2350.50,
          "currentSpotPrice": 2350.50
        }
      }
    ]
  }
}
```

### 8.5 Historial de Órdenes
- **URL:** `GET /api/order`
- **Query Params:**
  - `?per_page={n}` (opcional): Cantidad de elementos por página (default: 5).
- **Respuesta (200 OK):** Lista paginada que sigue la estructura estándar (`data`, `links`, `meta`) e incluye estadísticas globales (`invested`, `sold`) del cliente en el campo `stats`.
```json
{
  "data": [ ... ],
  "links": { ... },
  "meta": { ... },
  "stats": {
    "invested": { "amount": 5250.25, "count": 3 },
    "sold": { "amount": 0, "count": 0 }
  }
}
```

### 8.6 Ver Detalle de una Orden
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
    "created_at": "2026-04-24 16:02:59.000",
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
        "id": 10, "tracking_number": "1Z999...", "address": "Venezuela - Miranda - Guarenas - gua - n2", 
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
    - `name`, `email`, `phone`, `order_id` (opcionales): Para identificar al cliente o asociar a una orden. Si se envía `order_id`, el sistema valida que el `email` y `phone` correspondan al cliente de dicha orden.
  - **Respuesta (201 Created):**
  ```json
  {
    "success": true,
    "data": {
      "id": 1,
      "chat_room_id": 10,
      /* "sender_id": null, */
      "sender_type": "client",
      "message": "Hola...",
      "file_path": null,
      "file_type": null,
      "read_at": null,
      "created_at": "2026-06-18T15:00:00.000000Z"
    }
  }
  ```
  - **Errores:**
    - `422 Unprocessable Content`: Si el `order_id` no existe o no corresponde a los datos del cliente proporcionados.

- **Ver Historial (`GET /api/chat/{identifier}`):**
  - **Respuesta (200 OK):**
  ```json
  {
    "success": true,
    "data": {
      "id": 10,
      "identifier": "session_xxx",
      "client_name": "Juan Pérez",
      "operator_id": 2,
      "status": "active",
      "last_message_at": "2026-06-18 15:00:00",
      "created_at": "2026-06-18T14:00:00.000000Z",
      "messages": [
        {
          "id": 1,
          "chat_room_id": 10,
          /* "sender_id": null, */
          "sender_type": "client",
          "message": "Hola...",
          "file_path": null,
          "file_type": null,
          "read_at": "2026-06-18T14:30:00.000000Z",
          "created_at": "2026-06-18T14:00:00.000000Z"
        }
      ],
      "operator": { "id": 2, "name": "Soporte Papi Gold" }
    }
  }
  ```
  - **Errores:**
    - `404 Not Found`: Si el chat con el `identifier` proporcionado no existe.

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

### 9.4 Eventos en Tiempo Real (WebSockets)
- **Canal Público:** `settings`
- **Evento:** `settings.updated`
- **Data Recibida (Payload):**
```json
{
  "settings": {
    "site_name": "Papi Gold",
    "contact_email": "soporte@papi.gold",
    "social_links": { ... }
  }
}
```

---

## 10. Seguimiento de Envíos (Públicos)

### 10.1 Consultar Tracking
Obtiene el estado detallado y el historial de un envío utilizando su número de guía.
- **URL:** `GET /api/tracking`
- **Seguridad:** Requiere header `X-API-Key`.
- **Query Params:**
  - `?trackingNumber={string}` (requerido): El número de guía del envío proporcionado por el courier (ej. ZOOM, UPS).
- **Respuesta Exitosa (200 OK):**
```json
{
  "success": true,
  "data": {
    "order": "ORD-123",
    "tracking_number": "1234567890",
    "status": "ENTREGADO AL DESTINATARIO",
    "summary_steps": [
      {
        "id": "1",
        "label": "ENVIO PROCESADO EN ORIGEN",
        "status": "completed"
      },
      {
        "id": "21",
        "label": "ENTREGADO AL DESTINATARIO",
        "status": "current"
      }
    ],
    "history": [
      {
        "id": 21, 
        "date": "10/06/2026 16:08", 
        "status": "DISPONIBLE PARA EL RETIRO EN TAQUILLA", 
        "direction": "CARACAS - ZOOM CARACAS-CHACAO",
      },
      {
        "id": 1, 
        "date": "08/06/2026 15:08",
        "status": "ENVIO PROCESADO EN ORIGEN", 
        "direction": "CARACAS - ZOOM YAGUARA",
      },
      ...
    ],
    "fallback": false,
    "fallback_url": null,
    "address_shipping": "Av. Principal 123, Caracas, VE",
    "translations": {
      "en": {
        "status": "Delivery to Customer International Casillero - Time: 4: 08: 36 P.M.",
        "ENTREGADO AL DESTINATARIO": "Delivered to recipient",
        "ENVIO PROCESADO EN ORIGEN": "Shipment processed at origin",
        ...
      }
    }
  }
}
```

- **Respuesta con Redirección a Courier (Fallback) (200 OK):**
Ocurre cuando el sistema no puede obtener datos en tiempo real (por ejemplo, servicio externo caído o datos obsoletos) y sugiere consultar directamente en la web del transportista.
```json
{
  "success": true,
  "data": {
    "order": "ORD-123",
    "tracking_number": "1234567890",
    "status": "ENTREGADO",
    "summary_steps": [
      { "id": "1", "label": "RECIBIDO EN ORIGEN", "status": "completed" },
      { "id": "21", "label": "ENTREGADO AL DESTINATARIO", "status": "current" },
      ...
    ],
    "history": [
      {
        "id": 21, 
        "date": "10/06/2026 16:08", 
        "status": "DISPONIBLE PARA EL RETIRO EN TAQUILLA", 
        "direction": "CARACAS - ZOOM CARACAS-CHACAO",
      },
      {
        "id": 1, 
        "date": "08/06/2026 15:08",
        "status": "ENVIO PROCESADO EN ORIGEN", 
        "direction": "CARACAS - ZOOM YAGUARA",
      },
      ...
    ],
    "fallback": true,
    "fallback_url": "https://www.zoom.red/Tracking/Resultados?nro-guia=1234567890&tipo-consulta=1",
    "message": "En este momento no podemos obtener el detalle exacto. Por favor consulte el sitio del courier.",
    "address_shipping": "Av. Principal 123, Caracas, VE",
    "translations": { 
      "en": {
        "status": "Delivery to Customer International Casillero - Time: 4: 08: 36 P.M.",
        "ENTREGADO AL DESTINATARIO": "Available for The Retreat In Box Office",
        "ENVIO PROCESADO EN ORIGEN": "Envio Processed In Origin",
        ...
      }
    } 
  }
}
```

- **Errores:**
  - `422 Unprocessable Content`: Si el `trackingNumber` no es enviado o no es válido.
    - `500 Internal Server Error`: Si ocurre un error inesperado al procesar la solicitud.

---

## 11. Notificaciones del Cliente (Área Privada)

Endpoints para gestionar las notificaciones persistentes en la base de datos para el cliente autenticado.

### 11.1 Listar Notificaciones
Permite obtener el historial de notificaciones del cliente. Los datos están localizados según el idioma del cliente.
- **URL:** `GET /api/notifications`
- **Seguridad:** Requiere Bearer Token.
- **Query Params:**
  - `?per_page={n}` (opcional): Cantidad de elementos por página (default: 10).
- **Respuesta (200 OK):** Lista paginada de notificaciones siguiendo la estructura estándar (`data`, `links`, `meta`).
```json
{
  "data": [
    {
      "id": "9c6b96...",
      "type": "App\\Notifications\\OrderStatusChanged",
      "notifiable_type": "App\\Models\\Client",
      "notifiable_id": 5,
      "data": {
        "title": "Pedido #ORD-123",
        "body": "El estado de tu pedido ha cambiado a: Enviado",
        "order_id": "ORD-123",
        "status": "Enviado",
        "status": "info",
        "iconColor": "info",
        "icon": "heroicon-o-truck"
      },
      "read_at": null,
      "created_at": "2026-07-13 12:00:00"
    }
  ],
  "links": {
    "first": "http://api.papi.gold/api/notifications?page=1",
    "last": "http://api.papi.gold/api/notifications?page=5",
    "prev": null,
    "next": "http://api.papi.gold/api/notifications?page=2"
  },
  "meta": {
    "current_page": 1,
    "from": 1,
    "last_page": 1,
    "path": "...",
    "per_page": 10,
    "to": 1,
    "total": 1
  }
}
```

### 11.2 Obtener Contador de No Leídas
- **URL:** `GET /api/notifications/unread-count`
- **Seguridad:** Requiere Bearer Token.
- **Respuesta (200 OK):**
```json
{
  "count": 5
}
```

### 11.3 Marcar como Leída
- **URL:** `PUT /api/notifications/{id}`
- **Parámetro `{id}`**: Puede ser el UUID de la notificación o el valor literal `all` para marcar todas.
- **Seguridad:** Requiere Bearer Token.
- **Respuesta (200 OK):**
```json
{
  "success": true
}
```

### 11.4 Webhook de Notificaciones (Eventos en Tiempo Real)
El sistema emite eventos a través de WebSockets (Laravel Reverb) para que el cliente reciba notificaciones instantáneas.
- **Canal Privado:** `client.{id}`
- **Evento:** `notification.received`
- **Data Recibida (Payload):**
```json
{
  "id": "9c6b96...",
  "title": "Actualización de Pedido",
  "message": "Tu pedido #ORD-123 ha sido aprobado.",
  "type": "order_status",
  "metadata": {
    "order_id": "ORD-123",
    "status": "approved"
  }
}
```

---

## 12. Manejo de Errores

| Código | Código de Error (`code`) | Descripción |
| :--- | :--- | :--- |
| `409` | `price_changed` | El precio subió durante el proceso. |
| `409` | `client_exists_confirmation_required` | El cliente ya existe, requiere `confirm_existing_client: true`. |
| `422` | `insufficient_stock` | Stock insuficiente disponible. |
| `422` | (Validación) | Errores de validación en el campo `errors`. |
| `500` | (Error Interno) | Error al procesar el tracking o falla del servicio. |

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
