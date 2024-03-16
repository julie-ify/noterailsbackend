# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorized

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: 'Access Denied', reason: exception.message, status: :forbidden }, status: :unauthorized
  end

  def current_user
    @current_user ||= User.find_by(id: decoded_token[0]['user_id'])
  end

  def encode_token(payload)
    JWT.encode(payload, 'yourSecret')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split(' ')[1]
    begin
      JWT.decode(token, 'yourSecret', true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end

  def logged_in_user
    return unless decoded_token

    decoded_token[0]['user_id']
    current_user
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
