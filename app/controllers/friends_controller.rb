require 'sentimentalizer/lib/api/api'
require 'json'

class FriendsController < ApplicationController
  # GET /friends
  # GET /friends.json
  def index
    @oauth = Koala::Facebook::OAuth.new("369600096459806", "8f4f1a508ccc95b4ca0d373897591ea7", "http://127.0.0.1:3000"+friends_path)
    oauth_access_token = @oauth.get_access_token(params[:code])
    @graph = Koala::Facebook::API.new(oauth_access_token)
    friends = @graph.get_connections("me", "friends",{:limit => 200 })
    @friends = Array.new
    friends.each do |f|
      status = @graph.get_connections(f["id"],"statuses",{:since => Date.yesterday, :limit =>1})
      unless status.empty?
        current = 0
        begin
          f["status"] = JSON.parse($SENT_API.analyze(status[0]["message"]))
          f["status"]["id"] = status[0]["id"]
        rescue NoMethodError
          puts "Chinese!"
          current = 1
        end
        if current == 0
          @friends << f
        end
      end
      puts @friends
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @friends }
    end
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
    @friend = Friend.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @friend }
    end
  end

  # GET /friends/new
  # GET /friends/new.json
  def new
    @friend = Friend.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @friend }
    end
  end

  # GET /friends/1/edit
  def edit
    @friend = Friend.find(params[:id])
  end

  # POST /friends
  # POST /friends.json
  def create
    @friend = Friend.new(params[:friend])

    respond_to do |format|
      if @friend.save
        format.html { redirect_to @friend, notice: 'Friend was successfully created.' }
        format.json { render json: @friend, status: :created, location: @friend }
      else
        format.html { render action: "new" }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /friends/1
  # PUT /friends/1.json
  def update
    @friend = Friend.find(params[:id])

    respond_to do |format|
      if @friend.update_attributes(params[:friend])
        format.html { redirect_to @friend, notice: 'Friend was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
    @friend = Friend.find(params[:id])
    @friend.destroy

    respond_to do |format|
      format.html { redirect_to friends_url }
      format.json { head :no_content }
    end
  end




end
