# frozen_string_literal: true

require 'discordrb'
require 'dotenv'

Dotenv.load("secrets.env")

DISCORD_BOT_KEY = ENV['DISCORD_BOT_KEY']
bot = Discordrb::Bot.new token: DISCORD_BOT_KEY

bot.message(start_with: 's::introduction') do |event|
    languages = ['hi!', 'hola!', 'bonjour!', 'oi!', '안녕!']
    language_number = rand(1..5)
    message = languages[language_number]
    event.respond!(content: "#{message}, i\'m snakBot! a discord bot built by @snakatakka! i was programmed in ruby, and you can find the source code on snakatakka\'s github!")
end

# keeps the bot online
bot.run