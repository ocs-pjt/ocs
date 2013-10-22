class AuthTokensController < ApplicationController

  # Generate the auth_token if it doesn't exist already
  def create_or_get
    if (collector_id = params[:collector_id].to_i) != 0

      filename = Utils.filename(::Collector.find(collector_id).name)

      unless token = AuthToken.find_by(user_id: current_user.id, collector_id: collector_id).try(:token)
        cipher = OpenSSL::Cipher.new("aes-256-cbc")
        cipher.encrypt
        key = File.read('.digest')
        iv = cipher.random_iv

        # load them into the cipher
        cipher.key = key
        cipher.iv = iv

        # encrypt the message
        encrypted = cipher.update("#{User.find(current_user.id).email} #{filename}")
        encrypted << cipher.final

        out_file = File.new(filename, "w:ASCII-8BIT")
        out_file.puts(encrypted)
        out_file.close

        at = AuthToken.new
        at.token = File.open(filename)
        at.user_id = current_user.id
        at.collector_id = collector_id
        at.save!

        File.delete(filename)

        token = at.token
      end
      json = {message: 'ok', url: token.try(:url), filename: filename}
    else
      json = {message: 'Invalid collector'}
    end

    render json: json if request.xhr?
  end

end