class PagesController < ApplicationController
    before_action :get_time, :set_meta, :get_twitter

    ENV['GITHUB_CLIENT_ID'] = "4a58aeefe3e9a11848b3"
    ENV['GITHUB_CLIENT_SECRET'] = "af1e45e9de3494eef801916244b6681cbc421e6b"
    ENV['TWITTER_CONSUMER_KEY'] = "yrYnUlmsruuSXo7g0DdM2eU46"
    ENV['TWITTER_CONSUMER_SECRET'] = "plFacj5QBkT4LG1wdJp41nNvLdMpSyCDOoQBBpF15oUDH7HfDt"
    ENV['TWITTER_ACCESS_TOKEN'] = "1061592747302416385-iOzzMm6vcHQQUqUtdN6DaDeCOMocAc"
    ENV['TWITTER_ACCESS_SECRET'] = "7ee2TgaclO1T6VO9I4loz2kgCfpTdN8jqH1fGqhcSKJSO"

    # GET /
    def home
        @route_path = "posts"
        @meta_title = "Michael Sjöberg"
        
        json_file = File.read(Rails.public_path + 'posts.json')
        @posts = JSON.parse(json_file)

        @counter = 0
    end

    # GET /programming
    def programming
        @route_path = "technical-notes"
        @meta_title = "Technical Notes"
        @category = params[:category]
        @group = params[:group]
        @file = params[:file]

        json_file = File.read(Rails.public_path + 'programming.json')
        @programming = JSON.parse(json_file)

        unless (@file.nil?)
            @meta_title = @file.titleize + " -- " + @category.titleize
            # define file properties
            @path = @programming[@category][@group]["path"]
            @format = @programming[@category][@group]["format"]

            # get raw file content from github
            begin
                @content = HTTParty.get(@path + "#{@group}/#{@file}" + @format).parsed_response
            rescue
                @content = nil
            end
        end
    end

    # GET /projects
    def projects
        @route_path = "projects"
        @meta_title = "Projects"

        json_file = File.read(Rails.public_path + 'projects.json')
        @projects = JSON.parse(json_file)
    end

    # GET /posts
    def posts
        @route_path = "posts"
        @meta_title = "Posts"
        @post = params[:post]

        json_file = File.read(Rails.public_path + 'posts.json')
        @posts = JSON.parse(json_file)

        unless (@post.nil?)
            @post_title = @posts[@post]["title"]
            @first_paragraph = @posts[@post]['body'][0]

            # override meta
            @meta_title = @post_title
            @meta_description = @first_paragraph
        end
    end

    # GET /about
    def about
        @route_path = "about"
        @meta_title = "About"
    end

    private
        def get_time
            @time = Time.now
        end

        def set_meta
            @meta_image = "https://www.michaelsjoeberg.com/assets/profile_sm-35d6b3ed947ff3d2d19abfe183ac21e6bef49399fb4bad40552d3be4beff3442.jpg"
            @meta_site_name = "michaelsjoeberg.com"
            @meta_card_type = "summary"
            @meta_author = "@sjoebergco"
        end

        def get_github
            url = "https://api.github.com/users/michaelsjoeberg/events?client_id=#{ENV['GITHUB_CLIENT_ID']}&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}"
            @commits = HTTParty.get(url).parsed_response
        end

        def get_twitter
            begin
                twitter_client = Twitter::REST::Client.new do |config|
                    config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
                    config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
                    config.access_token = ENV['TWITTER_ACCESS_TOKEN']
                    config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
                end
                @tweets = twitter_client.user_timeline("sjoebergco")
                @location = @tweets[0].user.location
            rescue
                @tweets = nil
                @location = nil
            end
        end
end