class RedirectToActiveGame < BaseMiddleware
  def initialize(app)
    super()
    @app = app
  end

  def call(env)
    request_params(env)

    return @app.call(env) if @game.nil?
    return @app.call(env) if @game.lose? || @game.win?
    return @app.call(env) if @path == Constants::GAME_PATH

    redirect(Constants::GAME_PATH)
  end
end
