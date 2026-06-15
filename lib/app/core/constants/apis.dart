abstract class Apis {
  // static const baseUrl = 'https://papigold.io/api/';
  static const baseUrl = 'http://192.168.100.162:8000/api/';

  // AUTH
  static const login = 'session';
  static const register = '';
  static const recovery = '';

  static const product = 'product';
  static const price = 'price';
  static  const countries = 'location';
  static const location = 'location/show';

  static const order = 'order';
  static const paymentIntent = 'payment';
  static const chat = 'chat';
  static const client = 'client/me';

  // envio de consulta via formulario
  static const consultation = 'consultation';
}