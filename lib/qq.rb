require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Qq < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "qq"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, { 
        :site              =>   'https://graph.qq.com',
        :authorize_url     =>   '/oauth2.0/authorize',
        :token_url         =>   '/oauth2.0/token'
      }

      option :authorize_params, {
        :redirect_uri => CONFIG["qq_callback_url"]
      } 

      option :token_params, {
        # SET :parse because weibo oauth2 access_token response with "content-type"=>"text/plain;charset=UTF-8",
        # and when you use ruby 1.8.7, the response body was not a valid HASH (see: https://github.com/intridea/oauth2/issues/75)
        # :body=>"{\"access_token\":\"2.001FOK5CacB2wCc20a59773d0uSGnj\",\"expires_in\":86400,\"uid\":\"2189335154\"}"}
        :parse => :query
      }      

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.

      uid { raw_info['openid'] }

      info do
        {
          :nickname => raw_info['nickname'],
          :name => raw_info['nickname'],
          :location => raw_info['province'],
          :city => raw_info['city'],
          :avatar_url => raw_info['figureurl_2']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        access_token.options[:mode] = :query
        access_token.options[:param_name] = 'access_token'
        resp = access_token.get('oauth2.0/me').body
        resp = MultiJson.load resp.match(/callback\((.*?)\)/)[1].strip

        @user_info ||= access_token.get("user/get_user_info", :params => { 
          :openid             => resp["openid"],
          :oauth_consumer_key => CONFIG["qq_key"]
        }).body

        @raw_info = MultiJson.load @user_info
        @raw_info.merge!("openid" => resp["openid"]) 
        @raw_info
      end

    end
  end
end
