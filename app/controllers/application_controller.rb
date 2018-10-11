class ApplicationController < ActionController::API
  before_action :authorized

 def encode_token(payload)
   puts 'this is the payload!!!'
   puts '###########################################'
   puts payload
   ###this is good. correct user is showing up
   JWT.encode(payload, nil, 'none')
 end

 # def auth_header
 #   ##THIS MAY BE WHERE THINGS ARE SCREWING UP
 #   ###EVERYTHING IS FINE UNTIL DECODED_TOKEN BELOW
 #   ####WHEN THE BELOW METHOD CALLS ON AUTH_HEADER, IT GIVES THE WRONG INFO
 #   #####IT SEEMS THAT THE REQUEST.HEADERS DOESNT UPDATE UNTIL TOO LATE.
 #   byebug
 #   request.headers["Authorization"]
 # end

 def decoded_token
   if request.headers["Authorization"]
       token = request.headers["Authorization"].split(" ")[1] #header: {'Authorization': 'Bearer JWTTOKEN'}
       begin
         JWT.decode(token, ENV["SECRET"], true, { algorithm: ENV["ALG"] })
       rescue JWT::DecodeError
         [{}]
       end
   end
 end

 def current_user
   if decoded_token
     # byebug
     user_id = decoded_token[0]["user_id"]
     @user = User.find_by(id: user_id)
   end
 end

 def logged_in?
   !!current_user
 end

 def authorized
   render json: {message: "Please log in"}, status: 401 unless logged_in?
 end

end
