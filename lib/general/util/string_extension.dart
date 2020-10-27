extension StringExtensions on String {
  bool get isNullOrBlank => this == null || this.isBlank;

  bool get isBlank => this.trim().isEmpty;

  String orDefault(String defaultValue) => this.isNullOrBlank ? defaultValue : this;
}
