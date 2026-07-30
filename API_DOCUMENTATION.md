# Documentación de la API Headless - Papi Gold

Esta documentación detalla el uso, funcionamiento y estructura de la API Headless de Papi Gold. Todos los endpoints devuelven respuestas en formato JSON.

---

## 1. Utilidades y Salud

### 1.1 Health Check (Estado del Servidor)
Permite monitorear la salud del servidor y la conexión a la base de datos de forma pública.
- **URL:** `GET /api/health`
- **Parámetros:** Ninguno.
- **Respuesta (200 OK):**
```json
{
  "status": "ok",
  "db_status": "ok",
  "timestamp": "2026-06-10T14:30:00.000000Z"
}
```
- **Errores:**
  - `500 Internal Server Error`: Si el servidor o la base de datos no están disponibles.

### 1.2 Webhook de Stripe
Punto de entrada para que Stripe notifique cambios de estado en los pagos de forma asíncrona. 
- **URL:** `POST /api/stripe/webhook`
- **Parámetros (Headers):**
  - `Stripe-Signature` (requerido): Firma para validación de autenticidad.
- **Eventos Procesados:**
  - `payment_intent.succeeded`: El pago se completó exitosamente. Actualiza la venta a **Aprobado**, reduce el stock aloof e incrementa el stock de venta real.
  - `payment_intent.payment_failed`: El pago falló. Actualiza el estado a **Fallido**.
  - `payment_intent.processing`, `payment_intent.canceled`, `payment_intent.requires_action`.
  - `charge.refunded`: El cargo fue reembolsado. Actualiza el estado a **Reintegrado**.
- **Ejemplo de Petición (Payload de Stripe):**
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
- **Respuesta (200 OK):**
```json
{
  "status": "success",
  "message": "Webhook processed: payment_intent.succeeded"
}
```
- **Errores:**
  - `400 Bad Request`: Si la firma es inválida o el payload está mal formado.

---

## 2. Arquitectura y Seguridad

La API utiliza capas de seguridad obligatorias para proteger los datos y asegurar que solo las aplicaciones autorizadas interactúen con ella.

### 2.1 App Key (Header X-API-Key)
Requerido para **todas** las peticiones públicas (bajo el middleware `app_key`).
- **Header:** `X-API-Key`
- **Valor:** Definido en el entorno del servidor (ej. `base64:vI6...`)

### 2.2 Autenticación Sanctum (Bearer Token)
Requerido para endpoints del área privada del cliente. Los tokens emitidos pueden tener alcances (scopes):
- `full-access`: Permite realizar acciones críticas como cambiar la contraseña.
- **Header:** `Authorization: Bearer {token}`

### 2.3 Sistema de Traducciones
La mayoría de los recursos devuelven un campo `translations` que contiene las versiones localizadas de los campos descriptivos.
- **Formato:** Objeto con códigos de idioma (ISO 639-1) como llaves.
- **Ejemplo:**
```json
"translations": {
  "en": { "name": "Gold Ring", "description": "Beautiful ring..." },
  "es": { "name": "Anillo de Oro", "description": "Hermoso anillo..." }
}
```

### 2.4 Actualizaciones en Tiempo Real (WebSockets)
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

Para canales públicos y privados, se recomienda la siguiente configuración. Los canales privados requieren el token de autenticación del cliente.

```javascript
import Echo from 'laravel-echo';
import Pusher from 'pusher-js';

window.Pusher = Pusher;

const echo = new Echo({
  broadcaster: 'reverb',
  key: 'TU_REVERB_KEY',
  wsHost: 'direccion-web',
  wsPort: 443,
  forceTLS: true,
  enabledTransports: ['ws', 'wss'],
  // Requerido para Canales Privados:
  authEndpoint: 'https://direccion-web/api/broadcasting/auth',
  auth: {
    headers: {
      Authorization: `Bearer {TOKEN_DEL_CLIENTE}`,
      Accept: 'application/json',
    },
  },
});

// --- CANALES PÚBLICOS ---

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

// Escuchar cambios en ajustes globales
echo.channel('settings')
  .listen('.settings.updated', (data) => {
    console.log('Ajustes actualizados:', data.settings);
  });

// --- CANALES PRIVADOS (Requiere Autenticación) ---

const clientId = 5; // ID del cliente autenticado

// Notificaciones y Actualizaciones de Pedidos
echo.private(`client.${clientId}`)
  .listen('.notification.received', (data) => {
    console.log('Nueva notificación:', data.title, data.message);
  })
  .listen('.sale.updated', (data) => {
    console.log('Pedido actualizado:', data);
  });

// Chat de Soporte
const chatIdentifier = 'session_xyz'; 
echo.join(`chat.${chatIdentifier}`)
  .listen('.message.sent', (data) => {
    console.log('Nuevo mensaje de chat:', data.message);
  });
```

---

## 3. Catálogo de Productos (Públicos)

### 3.1 Listar Productos
- **URL:** `GET /api/product`
- **Parámetros (Query Params):**
  - `per_page` (opcional): Cantidad de elementos por página (default: 4).
  - `metal` (opcional): Filtrar por ID de tipo de metal.
  - `category` (opcional): Filtrar por ID de categoría de producto.
- **Respuesta (200 OK):** Lista paginada agrupada por tipo de metal, incluyendo metadatos inteligentes de filtros disponibles.
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
             "translations": { "es": { "name": "Anillos" }, "en": { "name": "Rings" } } 
           }
        ],
        "translations": { "es": { "name": "Oro" }, "en": { "name": "Gold" } } 
      }
    ]
  }
}
```
- **Errores:**
  - `401 Unauthorized`: Si falta el `X-API-Key`.

### 3.2 Ver Producto Detallado
- **URL:** `GET /api/product/{id}`
- **Parámetros (Path Params):**
  - `id` (requerido): ID numérico del producto.
- **Respuesta (200 OK):** Objeto `ProductResource`.
```json
{
  "data": {
    "id": 10,
    "name": "Anillo Clásico",
    "description": "Anillo de oro...",
    "stock": 5,
    "imagen": "...",
    "price": 1250.50,
    "category": { "id": 1, "name": "Anillos" },
    "translations": { "es": { "name": "Anillo..." }, "en": { "name": "Ring..." } }
  }
}
```
- **Errores:**
  - `404 Not Found`: Si el producto no existe.
  - `401 Unauthorized`: Si falta el `X-API-Key`.

### 3.3 Eventos en Tiempo Real (WebSockets)
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

### 4.1 Listar Precios Actuales
- **URL:** `GET /api/price`
- **Parámetros:** Ninguno.
- **Respuesta (200 OK):** Análisis completo de metales activos. El campo `categories` contiene la representación minimalista de los productos de ese metal.
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
- **Errores:**
  - `401 Unauthorized`: Si falta el `X-API-Key`.

### 4.2 Historial y Detalle por Metal
- **URL:** `GET /api/price/{symbol}`
- **Parámetros (Path Params):**
  - `symbol` (requerido): Símbolo del metal (ej. `XAU`).
- **Respuesta (200 OK):** La respuesta devuelve un **array** dentro del campo `data` con la misma estructura normalizada que el listado general.
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
- **Errores:**
  - `404 Not Found`: Si el símbolo del metal no existe.

### 4.3 Eventos en Tiempo Real (WebSockets)
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

### 5.1 Listar Países
Obtiene la lista de países configurados como activos en el sistema.
- **URL:** `GET /api/location`
- **Parámetros:** Ninguno.
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
    ...
  ]
}
```
- **Errores:**
  - `401 Unauthorized`: Si falta el `X-API-Key`.

### 5.2 Ver Estados o Ciudades
Filtra ubicaciones geográficas de forma jerárquica.
- **URL:** `GET /api/location/show`
- **Parámetros (Query Params):**
  - `country` (requerido): ID del país.
  - `state` (opcional): ID del estado (para obtener ciudades).
- **Respuesta (200 OK):**
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
  - `401 Unauthorized`: Si falta el `X-API-Key`.

### 5.3 Mapeo de Ubicación GPS a IDs internos
Permite convertir coordenadas geográficas (`lat`/`lon`) en IDs internos del sistema (`country_id`, `state_id`, `city_id`) y obtener datos de dirección formateados para autocompletar formularios. El servidor consulta internamente servicios de geocodificación inversa.
- **URL:** `POST /api/location/map-names`
- **Uso Recomendado:** 
  1. Obtener coordenadas `lat` y `lon` del navegador o dispositivo del cliente.
  2. Enviar directamente las coordenadas a este endpoint.
- **Parámetros (Request Body):**
  - `lat` (requerido): Latitud numérica.
  - `lon` (requerido): Longitud numérica.
- **Ejemplo de Petición:**
```json
{
  "lat": 10.4806,
  "lon": -66.9036
}
```
- **Respuesta (200 OK):**
```json
{
  "country_id": 239,
  "state_id": 3939,
  "city_id": 47265,
  "address1": "Avenida Universidad",
  "code_zip": "1010"
}
```
- **Errores:**
  - `422 Unprocessable Content`: Si faltan las coordenadas o son inválidas.
    ```json
    {
      "message": "Los datos proporcionados no son válidos.",
      "errors": {
        "lat": ["El campo lat es obligatorio."],
        "lon": ["El campo lon es obligatorio."]
      }
    }
    ```
  - `404 Not Found (Geocodificación Fallida)`: Si Nominatim no puede resolver las coordenadas.
    ```json
    {
      "message": "No se encontró la ubicación solicitada."
    }
    ```
  - `404 Not Found (País no soportado)`: Si la ubicación se resuelve pero el país no está activo en la base de datos interna.
    ```json
    {
      "message": "No se encontró la ubicación solicitada. (España)",
      "result": {
        "country_id": null,
        "state_id": null,
        "city_id": null,
        "code_zip": "28001",
        "address1": "Calle Mayor 1",
        "errors": {
          "country": "No se encontró la ubicación solicitada. (España)"
        }
      }
    }
    ```
  - **Éxito con Errores Parciales (200 OK):** Si el país existe pero el estado o ciudad no se encuentran en la base de datos local.
    ```json
    {
      "country_id": 1,
      "state_id": null,
      "city_id": null,
      "code_zip": "1010",
      "address1": "Av. Principal",
      "errors": {
        "state": "No se encontró la ubicación solicitada. (Estado Desconocido)"
      }
    }
    ```
  - `401 Unauthorized`: Si falta el `X-API-Key` o `Bearer Token`.

---

## 6. Autenticación y Sesión

### 6.1 Magic Link (Acceso Temporal)
Permite el acceso a clientes que no tienen una contraseña establecida o que prefieren entrar vía enlace de correo.
- **URL:** `POST /api/request-access`
- **Parámetros (Request Body):**
  - `email` (requerido): Correo electrónico del cliente.
  - `invoice_number` (requerido): Número de factura/orden vinculada.
- **Respuesta (200 OK):**
```json
{
  "message": "Enlace enviado exitosamente."
}
```
- **Errores:**
  - `422 Unprocessable Content`: Si el cliente ya tiene contraseña o los datos son incorrectos.
  - `401 Unauthorized`: Si falta el `X-API-Key`.

### 6.2 Verificar Magic Link
Endpoint interno que verifica la firma y redirige al frontend.
- **URL:** `GET /api/request-access/verify`
- **Parámetros (Query Params):**
  - `token` (requerido): Token de acceso temporal.
  - `sale_id` (requerido): Número de factura.
- **Flujos de Redirección:**
  - **Éxito:** `{frontend_url}/verify-access?token={token}&sale_id={invoice_number}`
  - **Error:** `{frontend_url}/verify-access?error=expired|invalid`
- **Errores:**
  - `401 Unauthorized`: Token expirado o inválido.

### 6.3 Login (Sesión por Contraseña)
Autenticación tradicional para clientes con contraseña establecida.
- **URL:** `POST /api/session`
- **Parámetros (Request Body):**
  - `email` (requerido): Correo del usuario.
  - `password` (requerido): Contraseña del usuario.
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
- **Errores:**
  - `403 Forbidden`: Correo electrónico no verificado.
  - `422 Unprocessable Content`: Credenciales incorrectas o error de validación.

### 6.4 Refrescar Token
Permite renovar el token de sesión actual.
- **URL:** `PUT /api/session`
- **Parámetros:** Ninguno (Requiere Bearer Token en Header).
- **Respuesta (200 OK):**
```json
{
  "token": "2|XYZ...",
  "message": "Token refrescado exitosamente."
}
```
- **Errores:**
  - `401 Unauthorized`: Token inválido, expirado o falta App Key.

### 6.5 Logout
Cierra la sesión actual revocando el token Bearer.
- **URL:** `DELETE /api/session`
- **Parámetros:** Ninguno (Requiere Bearer Token en Header).
- **Respuesta (200 OK):**
```json
{
  "message": "Sesión cerrada correctamente."
}
```
- **Errores:**
  - `401 Unauthorized`: Token inválido o no proporcionado.

### 6.6 Registro de Clientes
Permite registrar un nuevo cliente en el sistema.
- **URL:** `POST /api/register`
- **Parámetros (Request Body):**
```json
{
  "name": "Juan", "lastname": "Pérez", "email": "juan@papi.com", "phone": "+584120000000",
  "country": 1, "state": 10, "city": 50, "address1": "Av...", "code_zip": "1010",
  "password": "Password123!", "password_confirmation": "Password123!"
}
```
- **Respuesta (201 Created):**
```json
{
  "message": "¡Registro exitoso! Por favor, verifica tu correo electrónico para activar tu cuenta.",
  "status": "pending_verification"
}
```
- **Errores:**
  - `422 Unprocessable Content`: Datos inválidos o duplicados (email/phone).

---

## 7. Proceso de Checkout y Pagos

### 7.1 Crear Orden (Checkout)
- **URL:** `POST /api/order`
- **Parámetros (Request Body):**
```json
{
  "clientData": {
    "name": "Juan", "lastname": "Pérez", "email": "juan@papi.com", ...
  },
  "cartItems": [
    { "id": 10, "quantity": 1, "price": 1250.50, "format": 1 }
  ],
  "address_id": 5, // ID de la dirección del cliente (opcional si se envía clientData completo)
  "confirm_existing_client": false
}
```
- **Respuesta (201 Created):**
```json
{
  "message": "Orden creada exitosamente",
  "sale": { "order": "ORD-123", "invoice_number": "PG-5521", "total_v": 1250.50 },
  "clientSecret": "pi_...", "paymentId": "pay_..."
}
```
- **Errores:**
  - `409 Conflict`: `price_changed` (el precio subió) o `client_exists_confirmation_required`.
  - `422 Unprocessable Content`: `insufficient_stock` o errores de validación.

### 7.2 Refrescar Intento de Pago
Genera una nueva intención de pago para una orden existente.
- **URL:** `POST /api/payment`
- **Parámetros (Request Body):**
  - `sale_id` (requerido): ID o código de la orden.
- **Respuesta (200 OK):**
```json
{
  "clientSecret": "pi_...",
  "paymentId": "pay_..."
}
```
- **Errores:**
  - `404 Not Found`: Si la orden no existe.
  - `422 Unprocessable Content`: Si la orden ya está pagada o el monto es inválido.

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
- **Parámetros (Path Params):**
  - `id` (requerido): ID del cliente o `me`.
- **Cuerpo de Petición (Ejemplo):**
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
Endpoint dedicado exclusivamente al cambio de contraseña. Requiere validación de identidad mediante `verification_code`.
- **URL:** `PUT /api/client/password`
- **Seguridad:** Requiere Bearer Token.
- **Nota sobre 2FA:** Este proceso requiere validación de identidad mediante `verification_code`.
- **Cuerpo de Petición (Ejemplo):**
```json
{
  "current_password": "mi_password_actual",
  "password": "nueva_contraseña_123",
  "password_confirmation": "nueva_contraseña_123",
  "verification_code": "123456"
}
```
 **Validación:** 
  - `current_password`: Obligatoria si el cliente ya tiene una contraseña establecida.
  - `password`: Mínimo 8 caracteres, debe incluir letras (mayúsculas y minúsculas), números y símbolos.
- **Respuesta (200 OK):**
```json
{
  "message": "Contraseña actualizada exitosamente."
}
```
- **Errores:**
  - `422 Unprocessable Content`:
    ```json
    {
      "message": "Los datos proporcionados no son válidos.",
      "errors": {
        "current_password": ["La contraseña actual no es correcta."],
        "password": ["La contraseña debe tener al menos 8 caracteres."]
      }
    }
    ```
  - `401 Unauthorized`: Token inválido.

### 8.4 Valuación de Activos (Portafolio)
Obtiene un resumen financiero de las compras del cliente.
- **URL:** `GET /api/valuation`
- **Parámetros:** Ninguno (Requiere Bearer Token en Header).
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
- **Errores:**
  - `401 Unauthorized`: Token inválido.

### 8.5 Historial de Órdenes
- **URL:** `GET /api/order`
- **Parámetros (Query Params):**
  - `per_page` (opcional): Cantidad de elementos por página (default: 5).
- **Respuesta (200 OK):** Lista paginada de órdenes e estadísticas globales.
```json
{
  "data": [ ... ],
  "stats": { "invested": { "amount": 5250.25, "count": 3 }, "sold": { "amount": 0, "count": 0 } }
}
```
- **Errores:**
  - `401 Unauthorized`: Token inválido.

### 8.6 Ver Detalle de una Orden
- **URL:** `GET /api/order/{order_code}`
- **Parámetros (Path Params):**
  - `order` (requerido): Código único de la orden (ej. `ORD-123`).
- **Respuesta (200 OK):** Objeto detallado de la orden, incluyendo items, pagos y envíos.
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
    "client": {
      "id": 13,
      "name": "Juan",
      "lastname": "Perez", 
      "country": { "id": 1, "name": "Venezuela", "phonecode": "93" },
      "state": { "id": 10, "name": "Distrito Capital" },
      "city": { "id": 50, "name": "Caracas" },
      "address1": "Av. Universidad",
      "address2": "Edf. Las Flores, Piso 2",
      "code_zip": "1210",
      "phone": "+584121234567",
      "emai": "jp@gmail.com",
      "receive_advertise": true,
      "password": true,
      "email_varified": true,
      "category": "Estandar"
    }
    "address": {
      "id": 1,
      "name": "Casa Principal",
      "country": "Venezuela",
      "state": "Distrito Capital",
      "city": "Caracas",
      "address1": "Av. Universidad",
      "address2": "Edf. Las Flores, Piso 2",
      "code_zip": "1010",
      "phone": "+584120000000",
      "is_profile_fallback": false
    },
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
    ]
  }
}
```
- **Errores:**
  - `404 Not Found`: Si la orden no existe.
  - `401 Unauthorized`: Token inválido.

---

## 9. Soporte y Configuración

### 9.1 Chat
- **Enviar Mensaje (`POST /api/chat`):** Envío de mensajes y archivos.
- **Parámetros (Request Body - Multipart):**
  - `identifier` (requerido): ID único de sesión/chat.
  - `message` (requerido si no hay file): Texto del mensaje.
  - `file` (opcional): Imagen (jpg, png, webp, max 10MB).
  - `order_id` (opcional): Para asociar a una orden.
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
  - `422 Unprocessable Content`: Si el `order_id` no existe o no corresponde al cliente.

- **Ver Historial (`GET /api/chat/{identifier}`):**
- **Parámetros (Path Params):**
  - `identifier` (requerido): ID único de sesión/chat.
- **Respuesta (200 OK):** Historial completo de mensajes.
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
  - `404 Not Found`: Si el chat no existe.

### 9.2 Formulario de Contacto (Consulta)
- **URL:** `POST /api/consultation`
- **Parámetros (Request Body):**
  - `name`, `email`, `phone`, `type`, `details` (requeridos).
- **Respuesta (201 Created):**
```json
{ "message": "Consulta enviada exitosamente." }
```
- **Errores:**
  - `422 Unprocessable Content`: Errores de validación.

### 9.3 Ajustes Globales
Obtiene configuraciones públicas dinámicas del sitio.
- **URL:** `GET /api/settings`
- **Parámetros:** Ninguno.
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
Actualización de ajustes globales.
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
Obtiene el estado detallado de un envío.
- **URL:** `GET /api/tracking`
- **Parámetros (Query Params):**
  - `trackingNumber` (requerido): Número de guía.
- **Respuesta (200 OK):** Detalle del envío, pasos del resumen e historial.
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
        "date": "10/06/2026 16:08", 
        "status": "completed"
      },
      {
        "id": "21",
        "label": "ENTREGADO AL DESTINATARIO",
        "date": "10/06/2026 16:08", 
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
- **Nota Fallback:** Si no se obtienen datos en tiempo real, devuelve `fallback: true` con `fallback_url`.
- **Errores:**
  - `422 Unprocessable Content`: Número de guía inválido.
  - `500 Internal Server Error`: Falla en servicio de courier.

---

## 11. Notificaciones del Cliente (Área Privada)

### 11.1 Listar Notificaciones
- **URL:** `GET /api/notifications`
- **Parámetros (Query Params):**
  - `per_page` (opcional): default 10.
- **Respuesta (200 OK):** Lista paginada de notificaciones localizadas.
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
- **Errores:**
  - `401 Unauthorized`: Token inválido.

### 11.2 Contador de No Leídas
- **URL:** `GET /api/notifications/unread-count`
- **Respuesta (200 OK):** `{ "count": 5 }`

### 11.3 Marcar como Leída
- **URL:** `PUT /api/notifications/{id}`
- **Parámetros (Path Params):**
  - `id` (requerido): UUID o `all`.
- **Respuesta (200 OK):** `{ "success": true }`

### 11.4 Webhook de Notificaciones (WebSockets)
- **Canal Privado:** `client.{id}`
- **Evento:** `notification.received`
- **Data Recibida:** Objeto notificación.
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

## 12. Direcciones del Cliente (Área Privada)

### 12.1 Listar Direcciones
- **URL:** `GET /api/client/address`
- **Parámetros (Query Params):**
  - `per_page` (opcional): default 4.
- **Respuesta (200 OK):** Lista de direcciones adicionales y la `primary_address`.
```json
{
  "data": [
    {
      "id": 1,
      "name": "Casa Principal",
      "country": { "id": 1, "name": "Venezuela", "iso2": "VE" },
      "state": { "id": 10, "name": "Distrito Capital" },
      "city": { "id": 50, "name": "Caracas" },
      "address1": "Av. Universidad",
      "address2": "Edf. Las Flores, Piso 2",
      "code_zip": "1010",
      "phone": "+584120000000",
      "type": "both", //('shipping','receiving','both')
      "is_default": true
    },
    ...
  ],
  "primary_address": {
    "id": 5,
    "name": "Dirección de Registro",
    "country": { "id": 1, "name": "Venezuela" },
    "state": { "id": 10, "name": "Distrito Capital" },
    "city": { "id": 50, "name": "Caracas" },
    "address1": "Av. Principal",
    "address2": "Edif. Centro",
    "code_zip": "1010",
    "phone": "+58412...",
    "type": "primary",
    "is_default": false
  },
  "links": {
    "first": "http://api.papi.gold/api/client/address?page=1",
    "last": "http://api.papi.gold/api/client/address?page=5",
    "prev": null,
    "next": "http://api.papi.gold/api/client/address?page=2"
  },
  "meta": {
    "current_page": 1,
    "from": 1,
    "last_page": 5,
    "path": "http://api.papi.gold/api/client/address",
    "per_page": 4,
    "to": 4,
    "total": 20
  }
}
```

- **Errores:**
  - `401 Unauthorized`: Token inválido.

### 12.2 Crear Dirección
- **URL:** `POST /api/client/address`
- **Parámetros (Request Body):**
- **Cuerpo (JSON):**
```json
{
  "name": "Oficina",
  "country": 1,
  "state": 10,
  "city": 50,
  "address1": "Calle El Centro",
  "address2": "Torre B, Nivel 4",
  "code_zip": "1012",
  "phone": "+582125556677",
  "type": "shipping", 
  "is_default": false
}
```
- **Respuesta (201 Created):** `{ "data": { ... }, "primary_address": { ... } }`
- **Errores:**
  - `422 Unprocessable Content`: Validación fallida.

### 12.3 Ver Detalle de Dirección
- **URL:** `GET /api/client/address/{id}`
- **Parámetros (Path Params):**
  - `id` (requerido): ID de la dirección.
- **Respuesta (200 OK):** Objeto `data` con el recurso de la dirección.
- **Errores:**
  - `404 Not Found`: Si la dirección no existe.
  - `401 Unauthorized`: Token inválido.

### 12.4 Actualizar Dirección
- **URL:** `PUT /api/client/address/{id}`
- **Cuerpo de Petición (Ejemplo Parcial):**
```json
{
  "name": "Casa Nueva",
  "country": 1,
  "state": 10,
  "city": 50,
  "address1": "Av. Nueva Dirección 123",
  "address2": "Apto 4B",
  "code_zip": "1050",
  "phone": "+584121112233",
  "type": "shipping",
  "is_default": true
}
```
- **Respuesta (200 OK):** Retorna el objeto actualizado y la `primary_address`.
- **Errores:**
  - `422 Unprocessable Content`: Validación fallida.
  - `404 Not Found`: Si la dirección no existe.
  - `401 Unauthorized`: Token inválido.

### 12.5 Eliminar Dirección
- **URL:** `DELETE /api/client/address/{id}`
- **Respuesta (200 OK):**
```json
{
  "message": "Dirección eliminada exitosamente."
}
```
- **Errores:**
  - `404 Not Found`: Si la dirección no existe.
  - `401 Unauthorized`: Token inválido.
