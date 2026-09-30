enum BoxEnum {
  config(
    name: 'PAPI_GOLD',
    token: 'PAPI_GOLD_TOKEN',
    refreshToken: 'PAPI_GOLD_REFRESH_TOKEN',
    userLogged: 'PAPI_GOLD_LOGGED',
    isLogged: 'PAPI_GOLD_IS_LOGGED',
  );

  final String name;
  final String token;
  final String refreshToken;
  final String userLogged;
  final String isLogged;

  const BoxEnum({
    required this.name,
    required this.token,
    required this.refreshToken,
    required this.userLogged,
    required this.isLogged,
  });
}
