class Temple {
  final String title;
  // final double lat;
  // final double long;

  Temple({
    required this.title,
    // required this.lat,
    // required this.long,
  });

  factory Temple.fromJson(Map<String, dynamic> json) {
    return Temple(
      title: json['title'] ?? '',
      // lat: (json['lat'] ?? 0.0).toDouble(),
      // long: (json['long'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      // 'lat': lat,
      // 'long': long,
    };
  }
}
