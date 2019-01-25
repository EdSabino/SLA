require_relative "../../lib/models/model.rb"
require_relative "../../lib/models/require_models.rb"

class Volume < Model
    self.table_name = "irv"

    attr_accessor :id

    has_many :volumes_valores, class_name: "VolumeValor", foreign_key: :irv_id

end