# frozen_string_literal: false

require 'discordrb'
require 'dotenv'

Dotenv.load("secrets.env")

DISCORD_BOT_KEY = ENV['DISCORD_BOT_KEY']
bot = Discordrb::Bot.new token: DISCORD_BOT_KEY

# array of commands for s::commands
commands = [
    {'name' => "s::introduction", 'function' => "snakBot introduces itself! usually used as a test to see if the bot is functioning properly."},
    {'name' => "test", 'function' => "test"}
]


# all bot commands start with 's::'

bot.message(start_with: 's::commands') do |event|
    list_of_commands = ""
    commands.each do |command| # loops through commands and posts every command and its function
        # event.respond!(content: "`#{command['name']}` - #{command['function']}")
        list_of_commands.concat("`#{command['name']}` - #{command['function']} \n")
    end
    event.respond!(content: "#{list_of_commands}")
end


bot.message(start_with: 's::introduction') do |event|
    message = randomize_message()
    event.respond!(content: "#{message}, i\'m snakBot! a discord bot built by @snakatakka! i was programmed in ruby, and you can find the source code on snakatakka\'s github!")
    event.respond!(content: "you can use the s::commands command in order to view a list of all of my commands!")
end

def randomize_message()
    languages = ['hi!', 'hola!', 'bonjour!', 'oi!', '안녕!', 'aloha!', 'howdy!']
    language_number = rand(0..(languages.length() - 1))
    message = languages[language_number]
    return message
end

# keeps the bot online
bot.run