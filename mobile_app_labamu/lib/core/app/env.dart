class Env {
  static EnvValue? envValue;

  static String get baseUrl {
    switch (envValue) {
      case EnvValue.DEVELOPMENT:
        return "http://localhost:3000";
      case EnvValue.STAGING:
        return "http://localhost:3000";
      case EnvValue.PRODUCTION:
        return "http://localhost:3000";
      default:
        return "http://localhost:3000"; // development url
    }
  }

  static String get webSocketUrl {
    switch (envValue) {
      case EnvValue.DEVELOPMENT:
        return "";
      case EnvValue.STAGING:
        return "";
      case EnvValue.PRODUCTION:
        return "";
      default:
        return "";
    }
  }

  static bool get isDevelopment {
    switch (envValue) {
      case EnvValue.DEVELOPMENT:
        return false;
      case EnvValue.STAGING:
        return true;
      case EnvValue.PRODUCTION:
        return false;
      default:
        return true;
    }
  }

  static String get mapsToken {
    switch (envValue) {
      case EnvValue.DEVELOPMENT:
        return "";
      case EnvValue.STAGING:
        return "";
      case EnvValue.PRODUCTION:
        return "";
      default:
        return "";
    }
  }
}

enum EnvValue { DEVELOPMENT, STAGING, PRODUCTION }
