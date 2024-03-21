final class KueskieHeaders {
  KueskieHeaders._();
  static final Map<String, dynamic> defaultHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  static Map<String, dynamic> addEntry(Map<String, dynamic> entry) {
    defaultHeaders.addEntries(entry.entries);
    return defaultHeaders;
  }
}
