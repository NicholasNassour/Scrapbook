enum BadgeCategory {
  country,
  state,
  city,
  event,
}

class Badges {
  String? name;
  String? date;
  BadgeCategory category;

  Badges({this.name, this.date, required this.category});
}
