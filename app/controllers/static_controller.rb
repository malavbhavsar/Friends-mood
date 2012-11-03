class StaticController < ApplicationController
  def show
    @oauth = Koala::Facebook::OAuth.new("369600096459806", "8f4f1a508ccc95b4ca0d373897591ea7", "http://127.0.0.1:3000"+friends_path)

    @url = @oauth.url_for_oauth_code(:permissions => "friends_status")
  end
end
