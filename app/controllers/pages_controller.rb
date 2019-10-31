class PagesController < ApplicationController
    before_action :get_time, :set_meta, :get_twitter, :get_github

    # GET /
    def home
        @route_path = "posts"
        @meta_title = "Michael Sjöberg"
        
        #json_file = File.read(Rails.public_path + 'posts.json')
        #@posts = JSON.parse(json_file)

        @intro = JSON.parse(File.read(Rails.public_path + 'intro.json'))
        @typewriter = @intro['intro'].sample
        @steps = @typewriter.length

        #@counter = 0

        # TEST
        @posts = Dir.entries(Rails.public_path + 'posts/').drop(2).sort_by { | number | -number[0..-4].to_i }
        @post = @posts[0]

        @date = @post[0..-4]

        @lines = File.readlines(Rails.public_path + 'posts/' + @post)
        @title = @lines[0]
        @author = @lines[1]
    end

    # GET /technical-notes
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

    # GET /activity
    def activity
        @route_path = "activity"
        @meta_title = "Activity"
    end

    # GET /posts
    def posts
        @route_path = "posts"
        @meta_title = "Posts"
        @post = params[:post]

        #json_file = File.read(Rails.public_path + 'posts.json')
        #@posts = JSON.parse(json_file)

        #@public_path = Rails.public_path

        @posts_array = Hash.new

        @posts = Dir.entries(Rails.public_path + 'posts/').drop(2).sort_by { | number | -number[0..-4].to_i }

        @posts.each do |post|
            date = post[0..-4]
            lines = File.readlines(Rails.public_path + 'posts/' + post)
            title = lines[0]
            author = lines[1]

            @posts_array[date] = { title: title, author: author, lines: lines }
        end

        unless (@post.nil?)
            #@post = File.readlines(Rails.public_path + "posts/#{@post}.md")
            #@post_title = @post[0]
            #@first_paragraph = @posts[@post]['body'][0]

            #@date = @posts[0].split('_', 2)[0]
            #@title = @posts[0].split('_', 2)[1].gsub('_', ' ')[0..-4]

            #@file = @date + '_' + @title.gsub(' ', '_')

            #@post = File.readlines(Rails.public_path + "posts/#{@file}.md")

            @date = @post
            @file = @post + '.md'

            @lines = File.readlines(Rails.public_path + 'posts/' + @file)
            @title = @lines[0]
            @author = @lines[1]

            # override meta
            @meta_title = @title
            #@meta_description = @first_paragraph
        end
    end

    # GET /about
    def about
        @route_path = "about"
        @meta_title = "About"
    end

    # GET /about/courses
    def courses
        @route_path = "courses"
        @meta_title = "Course List"

        json_file = File.read(Rails.public_path + 'courses.json')
        @courses = JSON.parse(json_file)
    end

    # GET about/projects
    def projects
        @route_path = "projects"
        @meta_title = "Projects"

        json_file = File.read(Rails.public_path + 'projects.json')
        @projects = JSON.parse(json_file)
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