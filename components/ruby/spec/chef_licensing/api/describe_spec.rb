require "spec_helper"
require "chef_licensing/api/describe"
require "chef_licensing/config"

RSpec.describe ChefLicensing::Api::Describe do

  let(:license_keys) {
    ["tmns-bea68bbb-1e85-44ea-8b98-a654b011174b-4227"]
  }

  let(:opts) {
    {
      env_vars: {
        "CHEF_LICENSE_SERVER" => "http://localhost-license-server/License",
        "CHEF_LICENSE_SERVER_API_KEY" =>  "xDblv65Xt84wULmc8qTN78a3Dr2OuuKxa6GDvb67",
        "CHEF_PRODUCT_NAME" => "inspec",
        "CHEF_ENTITLEMENT_ID" => "testing_entitlement_id",
      },
    }
  }

  let(:config) {
    ChefLicensing::Config.clone.instance(opts)
  }

  let(:describe_api_data) {
    {
      "license" => [{
        "licenseKey" => "guid",
        "serialNumber" => "testing",
        "licenseType" => "testing",
        "status" => "active",
        "start" => "2022-12-02",
        "end" => "2023-12-02",
        "limits" => [
           {
            "testing" => "software",
             "id" => "guid",
             "amount" => 2,
             "measure" => 2,
             "used" => 2,
             "status" => "Active",
           },
        ],
      }],
      "Assets" => [
        {
          "id" => "guid",
          "name" => "testing",
          "entitled" => true,
          "from" => [
            {
                "license" => "guid",
                "status" => "expired",
            },
          ],
        }],
      "Software" => [
        {
          "id" => "guid",
          "name" => "testing",
          "entitled" => true,
          "from" => [
            {
                "license" => "guid",
                "status" => "expired",
            },
          ],
        }],
      "Features" => [
        {
          "id" => "guid",
          "name" => "testing",
          "entitled" => true,
          "from" => [
            {
                "license" => "guid",
                "status" => "expired",
            },
          ],
        }],
      "Services" => [
        {
          "id" => "guid",
          "name" => "testing",
          "entitled" => true,
          "from" => [
            {
                "license" => "guid",
                "status" => "expired",
            },
          ],
        }],
      }
  }

  subject { described_class.list(license_keys: license_keys, cl_config: config) }

  describe ".list" do
    before do
      stub_request(:get, "#{config.license_server_url}/desc")
        .with(query: { licenseId: license_keys.join(","), entitlementId: config.chef_entitlement_id })
        .to_return(body: { data: describe_api_data, status_code: 200 }.to_json,
                   headers: { content_type: "application/json" })
    end
    it { is_expected.to be_truthy }

    context "when license is invalid" do
      let(:error_message) { "Invalid licenses" }
      before do
        stub_request(:get, "#{config.license_server_url}/desc")
          .with(query: { licenseId: license_keys.join(","), entitlementId: config.chef_entitlement_id })
          .to_return(body: { data: false, message: error_message, status_code: 400 }.to_json,
                     headers: { content_type: "application/json" })
      end

      it { expect { subject }.to raise_error(ChefLicensing::DescribeError, error_message) }
    end
  end
end