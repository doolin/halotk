# frozen_string_literal: true

require_relative '../spec_helper'

module Halotk
  describe AccountManager do
    describe 'load keys from ENV' do
      before :all do
        ENV['JIRA_ID_DD'] = nil
        ENV['SCRUMTEST_API_KEY_DD'] = nil
        ENV['HALO_GRID'] = nil
        ENV['HALO_API_KEY_FILE'] = nil
      end

      it 'uses existing API keys' do
        fake_account = {
          'halo' => {
            'key_id' => 'some_key_id',
            'secret_key' => 'some_secret_key',
            'grid' => nil
          }
        }
        ENV['JIRA_ID_DD'] = 'some_key_id'
        ENV['SCRUMTEST_API_KEY_DD'] = 'some_secret_key'
        api_keys = AccountManager.new.api_keys
        expect(api_keys).to eq(fake_account)
      end
    end

    describe 'load keys from halo yaml file' do
      before do
        @fake_accounts = {
          'halo1' => {
            'key_id' => 'some_key_id',
            'secret_key' => 'some_secret_key'
          },
          'halo2' => {
            'key_id' => 'some_key_id2',
            'secret_key' => 'some_secret_key2',
            'grid' => 'api.somegrid.local'
          }
        }
      end

      it 'exits when no config file given and not environment specified' do
        ENV['HALO_API_KEY_FILE'] = nil
        ENV['JIRA_ID_DD'] = nil
        ENV['SCRUMTEST_API_KEY_DD'] = nil
        am = AccountManager.new
        expect { am.api_keys }.to raise_error RuntimeError
      end

      it 'loads locally specified config file' do
        api_keys = AccountManager.new('./spec/fixtures/halo_accounts.yml').api_keys
        expect(api_keys).to eq(@fake_accounts)
      end

      it 'loads locally specified config file' do
        ENV['HALO_API_KEY_FILE'] = './spec/fixtures/halo_accounts.yml'
        api_keys = AccountManager.new.api_keys
        expect(api_keys).to eq(@fake_accounts)
      end
    end
  end
end
