# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: 'Access Denied', reason: exception.message, status: :forbidden }, status: :unauthorized
  end

	def current_user
		@current_user ||= User.find_by(id: decoded_payload[0]['user_id'])
	end

	def authenticate_user!
		return unauthorized! if !decoded_payload || !valid_payload(decoded_payload.first)

		current_user
		unauthorized! unless @current_user
	end


  def encode_token(user_id)
		exp = 2.weeks.from_now.to_i
    payload = { user_id: user_id, exp: exp }

    JWT.encode(payload, 'yourSecret')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_payload
    return unless auth_header

    token = auth_header.split(' ')[1]
    JWT.decode(token, 'yourSecret', true, algorithm: 'HS256')
  rescue JWT::DecodeError, JWT::ExpiredSignature
    false
  end

	def valid_payload(payload)
    !expired(payload)
  end

  def expired(payload)
    Time.zone.at(payload['exp']) < Time.now.utc
  end

  def unauthorized!
    render json: { message: 'Please log in' }, status: :unauthorized
  end
end
