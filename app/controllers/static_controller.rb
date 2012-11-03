class StaticController < ApplicationController
  def show
    @oauth = Koala::Facebook::OAuth.new(Yetting.api_key, Yetting.app_secret, Yetting.site+friends_path)

    @url = @oauth.url_for_oauth_code(:permissions => "friends_status")

  end
end
