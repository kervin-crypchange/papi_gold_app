enum AppSocketsEnum {
  price( channel: 'prices', event: 'prices.updated' ),
  product( channel: 'products', event: 'product.updated' ),
  setting( channel: 'settings', event: 'settings.updated' ),
  notification( channel: 'client', event: 'notification.receive' ),
  sale( channel: 'client', event: 'sale.updates' );

  const AppSocketsEnum({
    required this.channel,
    required this.event
  });

  final String channel;
  final String event;
}