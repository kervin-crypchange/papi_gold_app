enum BoxEnum {
  config(
    name: 'PAPI_GOLD',
    token: 'PAPI_GOLD_TOKEN', 
    userLogged: 'PAPI_GOLD_LOGGED',   
  );

  final String name;
  final String token;
  final String userLogged;

  const BoxEnum({
    required this.name,
    required this.token,
    required this.userLogged,
  });
}