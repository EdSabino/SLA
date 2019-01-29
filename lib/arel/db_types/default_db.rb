require_relative "select_module/select_methods.rb"
require_relative "insert_module/insert_methods.rb"

class DefaultDb
    include SelectMethods
    include InsertMethods

    attr_accessor :subject

    def initialize(obj)
        @subject = obj
    end

end