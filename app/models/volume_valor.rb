require_relative "../../lib/models/model.rb"
require_relative "../../lib/models/require_models.rb"

class VolumeValor < Model
    self.table_name = "irv_val"

    belongs_to :volume, foreign_key: :irv_id

end