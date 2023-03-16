module ChefLicensing
  class LicenseKeyFetcher
    class Base
      # @example LICENSE UUID: tmns-58555821-925e-4a27-8fdc-e79dae5a425b-9763
      # @example SERIAL NUMBER: A8BCD1XS2B4F6FYBWG8TE0N49
      # 4[license type]-(8-4-4-4-12)[GUID]-4[timestamp]
      LICENSE_KEY_REGEX = "([a-z]{4}-[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}-[0-9]{1,4})".freeze
      LICENSE_KEY_PATTERN_DESC = "Hexadecimal".freeze
      # Serial number is a 25 character alphanumeric string
      SERIAL_KEY_REGEX = "([A-Z0-9]{25})".freeze
      SERIAL_KEY_PATTERN_DESC = "25 character alphanumeric string".freeze
      QUIT_KEY_REGEX = "(q|Q)".freeze
    end
  end
end
