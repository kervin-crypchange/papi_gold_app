enum BoxEnum {
  config(
    name: 'PAPI_GOLD',
    token: 'PAPI_GOLD_TOKEN',    
  );

  final String name;
  final String token;

  const BoxEnum({
    required this.name,
    required this.token,
  });
}