class PagesController < ApplicationController
    before_action :get_time, :set_meta, :get_twitter, :get_github

    # GET /
    def home
        @route_path = "posts"
        @meta_title = "Michael Sjöberg"

        # intro
        @intro = JSON.parse(File.read(Rails.public_path + 'intro.json'))
        @typewriter = @intro['intro'].sample
        @steps = @typewriter.length

        # read most recent post
        json_file = File.read(Rails.public_path + 'posts.json')
        @posts = JSON.parse(json_file)
        #@posts = Dir.entries(Rails.public_path + 'posts/').drop(2).sort_by { | number | -number[0..-4].to_i }
        
        @post = @posts.keys.first
        @file = @post + '.md'
        @date = @post
        @title = @posts[@date]['title']
        @lines = File.readlines(Rails.public_path + 'posts/' + @file)
    end

    # GET /programming
    def programming
        @route_path = "programming"
        @meta_title = "Programming"
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

    # GET /posts
    def posts
        @route_path = "posts"
        @meta_title = "Posts"
        @post = params[:post]

        json_file = File.read(Rails.public_path + 'posts.json')
        @posts = JSON.parse(json_file)

        #@public_path = Rails.public_path

        unless (@post.nil?)
            @file = @post + '.md'
            @date = @post
            @title = @posts[@date]['title']
            @lines = File.readlines(Rails.public_path + 'posts/' + @file)

            # override meta
            @meta_title = @title
            #@meta_description = @first_paragraph
        else
            @posts_array = Hash.new
            @posts.keys.each do |post|
                @file = post + '.md'
                @date = post
                @title = @posts[@date]['title']
                @tags = @posts[@date]['tags']

                @posts_array[@date] = { title: @title, tags: @tags,  }
            end
        end
    end

    # GET /about
    def about
        @route_path = "about"
        @meta_title = "About"

        json_file = File.read(Rails.public_path + 'projects.json')
        @projects = JSON.parse(json_file)
    end

    # GET /about/courses
    def courses
        @route_path = "courses"
        @meta_title = "Course List"

        json_file = File.read(Rails.public_path + 'courses.json')
        @courses = JSON.parse(json_file)
    end

    # GET /curriculum
    def curriculum
        @route_path = "curriculum"
        @meta_title = "The Ultimate Computer Science and Engineering Curriculum"
        #@meta_image = "https://www.michaelsjoeberg.com/assets/curriculum-d34071fe3c9d02283e6ab6435aed978ab0a2d2c74a974c11df12e242c1b04482.jpg"
        @level = params[:level]

        @EXCLUSIONS = %w(and to the in of)

        json_file = File.read(Rails.public_path + 'curriculum.json')
        @curriculum = JSON.parse(json_file)
    end

    private
        def get_time
            @time = Time.now
        end

        def set_meta
            @meta_image = "https://www.michaelsjoeberg.com/assets/profile_sm-35d6b3ed947ff3d2d19abfe183ac21e6bef49399fb4bad40552d3be4beff3442.jpg"
            #@meta_image = "https://www.michaelsjoeberg.com/assets/banner-8618f2bdcf140a0ea70ab3bc83ba382955820a890b81e77fe0069d80b68033ef.jpg"
            @meta_site_name = "michaelsjoeberg.com"
            @meta_card_type = "summary"
            @meta_author = "@sjoebergco"
        end

        def get_github
            url = "https://api.github.com/users/michaelsjoeberg/events/public?client_id=#{ENV['GITHUB_CLIENT_ID']}&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}"
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
                @description = (@tweets[0].user.description).split('--')[0]
            rescue
                @tweets = nil
                @location = nil
            end
        end
end