require "sinatra"
# another gem that sinatra has
require "sinatra/contrib"

require "sinatra/reloader" if development?
require_relative "./controllers/post_controller.rb"

use Rack::Reloader
use Rack::MethodOverride
run PostController
