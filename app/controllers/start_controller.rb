require_relative "../../lib/controllers/controller.rb"
require_relative "../../lib/models/require_models.rb"

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
        query = Volume.scoped.limit_to("10")
        @result = query.get_results_hash
    end
end