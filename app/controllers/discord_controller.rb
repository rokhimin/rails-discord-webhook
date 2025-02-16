require 'discordrb/webhooks'

class DiscordController < ApplicationController

  protect_from_forgery prepend: true
	skip_before_action :verify_authenticity_token
	
  def post
		
		#initialize
		discord_url = params[:url]
		discord_username = params[:username]
		discord_avatar_url = params[:avatar_url]
		discord_message = params[:message]
		discord_color = params[:color]
		discord_title = params[:title]
		discord_url_title = params[:url_title]
		discord_desc = params[:desc]
		discord_image = params[:image]
		discord_thumbnail = params[:thumbnail]
		discord_author_name = params[:author_name]
		discord_author_url = params[:author_url]
		discord_author_icon_url = params[:author_icon_url]
		discord_footer = params[:footer]
		discord_icon_footer = params[:icon_footer]
		discord_field_name = params[:field_name]
		discord_field_value = params[:field_value]
		
		

			discord_url.each do |data|

      @discord_url_ = "#{data[1]}"
        
			client = Discordrb::Webhooks::Client.new(url: data[1])

			client.execute do |builder|
			discord_username.each do |data|
			  builder.username = "#{data[1]}"
			end

			discord_avatar_url.each do |data|
			  builder.avatar_url = "#{data[1]}"
			end

			discord_message.each do |data|
  			builder.content = "#{data[1]}"
			end
			
			  builder.add_embed do |embed|
        
				embed.colour = discord_color
				  
				discord_title.each do |data|
					embed.title = "#{data[1]}"
				end
				  
				discord_url_title.each do |data|
					embed.url = "#{data[1]}"
				end
				  
				discord_desc.each do |data|
					embed.description = "#{data[1]}"
				end
				  
				discord_image.each do |data|
					embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{data[1]}")
				end
				  
				discord_thumbnail.each do |data|
 					embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "#{data[1]}")
				end
				
				discord_author_url.each do |data|
					@sigil_author_url = data[1]
				end
				discord_author_icon_url.each do |data|
					@sigil_author_icon_url = data[1]
				end
				  
				discord_author_name.each do |data|
					embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "#{data[1]}", url: "#{@sigil_author_url}", icon_url: "#{@sigil_author_icon_url}")
				end
				  
				discord_icon_footer.each do |data|
					@sigil_icon_footer = data[1]
				end
					
				discord_footer.each do |data|
  					embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "#{data[1]}", icon_url: "#{@sigil_icon_footer}")
				end
				  
				discord_field_value.each do |data|
					@sigil_field_value = data[1]
				end
				  
				discord_field_name.each do |data|
					unless @sigil_field_value == ''
				    	embed.add_field(name: "#{data[1]}", value: "#{@sigil_field_value}")
					else
					end
				end

			  end
			end 

    # Error Handling
		rescue ArgumentError
        @discord_response = 'Status : Form Null'
    rescue URI::InvalidURIError
        @discord_response = 'HTTP Status : 502 Bad gateway'
    rescue RestClient::NotFound
        @discord_response = 'HTTP Status : 404 Not Found'
    rescue RestClient::BadRequest
        @discord_response = 'HTTP Status : 400 Bad Request'
    rescue RestClient::Unauthorized
        @discord_response = 'HTTP Status : 401 Unauthorized'
    rescue SocketError
        @discord_response = 'HTTP Status : Socket error'
    else
        @discord_response = 'HTTP Status : 200 ok'
    end
		
				render "discord/index"

	end
	

end
