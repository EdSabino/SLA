require "erb"
require "pry"
# require_relative "require_controllers.rb"
require_relative "lib/after_execute.rb"
require_relative "database/accesser.rb"
require_relative "lib/arel/require_arel.rb"

class Controller

	extend AfterExecute

	attr_accessor :path, :method, :params

	def initialize(path, method, params)
		@path = path
		@method = method
		@params = params
		self.class.after(self.method) {read_file(self.path)}
	end

	def read_file(path)
		erb = ERB.new(File.open(path).read, 0, '>')
		return erb.result binding
	end


end