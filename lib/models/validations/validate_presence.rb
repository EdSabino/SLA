class ValidadePresence
    attr_accessor :fields

    def initialize(*opts)
        @fields = opts
    end

    def validate(object)
        self.fields.each do |field|
            object.errors << {field => :is_blank} if is_blank?(object.send("#{field}"))
        end
    end

    private

    def is_blank?(register)
        register.respond_to?(:empty?) ? register.empty? : !register
    end

end