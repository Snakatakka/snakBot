# frozen_string_literal: false

require 'discordrb'
require 'dotenv'

Dotenv.load("secrets.env")

DISCORD_BOT_KEY = ENV['DISCORD_BOT_KEY']
bot = Discordrb::Bot.new token: DISCORD_BOT_KEY

# array of commands for s::commands
commands = [
    {'name' => "s::commands", 'function' => "lists out all of snakBot's functions.", 'parameters' => "none"},
    {'name' => "s::introduction", 'function' => "snakBot introduces itself! usually used as a test to see if the bot is functioning properly.", 'parameters' => "none"},
    {'name' => "s::rank_contestant", 'function' => "adds a contestants ranking to a list of all contestant rankings", 'parameters' => "contestant, rank (must be a numerical value)"},
    {'name' => "s::get_contestant_rank", 'function' => "gets and returns a contestant's ranking, if they have one", 'parameters' => "contestant"}
]

rankings = {

}

# all bot commands start with 's::'

bot.message(start_with: 's::commands') do |event|

    list_of_commands = ""

    commands.each do |command| 
        list_of_commands.concat("`#{command['name']}` - #{command['function']} - parameters: #{command['parameters']} \n")
    end

    event.respond!(content: "#{list_of_commands} \n-# parameters are separated by spaces (i.e s::rank_contestant Foo 9.9)")
end

bot.message(start_with: 's::introduction') do |event|
    message = randomize_message()
    event.respond!(content: "#{message}, i\'m snakBot! a discord bot built by @snakatakka! i was programmed in ruby, and you can find the source code on snakatakka\'s github! \nyou can use the s::commands command in order to view a list of all of my commands!")
end

def randomize_message()
    languages = ['hi!', 'hola!', 'bonjour!', 'oi!', '안녕!', 'aloha!', 'howdy!']
    language_number = rand(0..(languages.length() - 1))
    message = languages[language_number]
    return message
end

bot.message(start_with: 's::rank_contestant') do |event|
    parameters = event.message.content.to_s.split
    name_parameter = parameters[1]
    ranking_parameter = parameters[2]

    rankings[name_parameter] = ranking_parameter.to_f
    event.respond!(content: "#{name_parameter} has a ranking of #{ranking_parameter}")
end

bot.message(start_with: 's::get_contestant_rank') do |event|
    parameters = event.message.content.to_s.split
    name_parameter = parameters[1]

    if rankings[name_parameter] != nil
        event.respond!(content: "#{name_parameter} has a ranking of #{rankings[name_parameter]}")
    else
        event.respond!(content: "ERROR: #{name_parameter} does not exist in rankings")
    end
end

# keeps the bot online
bot.run