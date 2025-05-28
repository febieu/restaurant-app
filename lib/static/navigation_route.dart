enum NavigationRoute {
  mainRoute("/"),
  homeRoute("/home"),
  detailRoute("/detail"),
  searchRoute("/search"),
  favoriteRoute("/favorite");

  const NavigationRoute(this.name);
  final String name;
}