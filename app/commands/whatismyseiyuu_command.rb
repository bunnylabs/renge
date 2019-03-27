# frozen_string_literal: true

# The What is my seiyuu command
class WhatismyseiyuuCommand < ApplicationCommand
  def divine?
    false
  end

  def public?
    false
  end
  
  def run
    return chat_service.reply('You have no seiyuu') unless seiyuu

    chat_service.reply("Your seiyuu is #{seiyuu.name}")
  end

  private

  def seiyuu
    chat_message.author.seiyuu
  end
end
