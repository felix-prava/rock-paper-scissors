class GameController < ApplicationController
    require 'uri'
    require 'net/http'

    def play_game
    end

    def curb_response
        uri = URI('https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com/rps-stage/throw')
        res = Net::HTTP.get_response(uri)
        curb_choice = ['rock', 'paper', 'scissors'].sample
        if res.is_a?(Net::HTTPSuccess)
            curb_choice = JSON.parse(res.body)["body"]
        end
        result = game_winner(params['user_choice'], curb_choice)
        render json: {choice: curb_choice, result: result}
    end

    private

    def game_winner(user, curb)
        return 'draw' if user == curb
        resource_value = {
            'rock': 1,
            'paper': 2,
            'scissors': 3
        }
        user_val = resource_value[user.to_sym]
        curb_val = resource_value[curb.to_sym]
        return 'lose' if user_val == 3 && curb_val == 1 || user_val + 1 == curb_val
        return 'won'
    end
end
