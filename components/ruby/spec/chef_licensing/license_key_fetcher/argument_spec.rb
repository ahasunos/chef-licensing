require "spec_helper"
require "chef_licensing/license_key_fetcher/argument"
require "chef_licensing/license_key_fetcher"

RSpec.describe ChefLicensing::LicenseKeyFetcher::Argument do
  describe "#fetch" do

    describe "when the argument contains the correct key and value" do
      let(:argv)  { ["--chef-license-key=tmns-0f76efaf-b45b-4d92-86b2-2d144ce73dfa-150"] }
      it "fetches the license key" do
        argv_fetcher = ChefLicensing::LicenseKeyFetcher::Argument.new(argv)
        expect(argv_fetcher.fetch).to eq(["tmns-0f76efaf-b45b-4d92-86b2-2d144ce73dfa-150"])
      end
    end

    describe "when the argument contains wrong license key value" do
      let(:argv) { ["--chef-license-key=wrongkindoflicensekeyvalue"] }
      it "raises malformed error while fetching" do
        argv_fetcher = ChefLicensing::LicenseKeyFetcher::Argument.new(argv)
        expect { argv_fetcher.fetch }.to raise_error(RuntimeError, /Malformed License Key passed on command line/)
      end
    end

    describe "when the argument contains empty license key value" do
      let(:argv) { ["--chef-license-key="] }
      it "raises malformed error while fetching" do
        argv_fetcher = ChefLicensing::LicenseKeyFetcher::Argument.new(argv)
        expect { argv_fetcher.fetch }.to raise_error(RuntimeError, /Malformed License Key passed on command line/)
      end
    end

    describe "when license key is not passed in argument" do
      let(:argv) { [] }
      it "returns an empty array" do
        argv_fetcher = ChefLicensing::LicenseKeyFetcher::Argument.new(argv)
        expect(argv_fetcher.fetch).to eq([])
      end
    end
  end
end