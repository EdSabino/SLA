require_relative "../controller.rb"
class StartController < Controller

    def index
        @name = params.any? ? params[:something] : "asdfa"
		@code = "asdasd"
		@desc = "ades"
        @cost = 1
        @features = [1, 2, 3]
    end

    def edit
        @uh = "ok"
        binding.pry
        # Accesser.new().connect_to_db(query)
    end
end