# frozen_string_literal: true

require 'yaml'

# setup the account specific API-Client key/secret and
# save these in a dot file like ~/.halo Reference the
# location as a ENV param instead of "hardcoding"
# them into this script (which may end up in a repo
# by mistake)
#
# the format of the yaml file ie ~/.halo
# halo-acct1:
#   key_id : XXXXXXX1
#   secret_key : XXXXXXXXXXXXXXXXXXXXXXXXXX1
#
# optionally, add a second, third etc. acct key/secret
# halo-acct2:
#   key_id : XXXXXXX2
#   secret_key : XXXXXXXXXXXXXXXXXXXXXXXXXX2
#
# and adding an additional grid param is supported as well
# halo-acct3:
#   key_id : XXXXXXX3
#   secret_key : XXXXXXXXXXXXXXXXXXXXXXXXXX3
#   grid : api.<unique>.cloudpassage.com
#
# don't forget to add and export HALO_API_KEY_FILE
# in your ~/.bash_profile Should look something like
# HALO_API_KEY_FILE="/home/ehoffmann/.halo"
# export HALO_API_KEY_FILE
#
# Alternatively, set the environment variables for
# JIRA_ID_DD and SCRUMTEST_API_KEY_DD.

module Halotk
  class AccountManager
    attr_reader :api_keys

    def initialize(config_file = nil)
      @config_file = (config_file || ENV['HALO_API_KEY_FILE'])
    end

    def api_keys
      @api_keys ||= load_accounts
    end

    def load_from_environment
      if ENV['JIRA_ID_DD'].nil? && ENV['SCRUMTEST_API_KEY_DD'].nil?
        raise("[ERROR] loading api_keys: #{e}") && exit
      end
      {
        'halo' => {
          'key_id' => ENV['JIRA_ID_DD'],
          'secret_key' => ENV['SCRUMTEST_API_KEY_DD'],
          'grid' => ENV['HALO_GRID']
        }
      }
    end

    def load_accounts
      @config_file.nil? ? load_from_environment : YAML.load_file(@config_file)
    rescue StandardError => e
      raise("[ERROR] loading api_keys: #{e}") && exit
    end
  end
end
