module ExtendString
    def camelize
        string = self
        string = string.sub(/^[a-z\d]*/) { $&.capitalize }
        string = string.sub(/^(?:(?=\b|[A-Z_])|\w)/) { $&.downcase }
        string.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$1}#{$2.capitalize}" }.gsub('/', '::')
    end

    def snakize
        self.split(/([[:upper:]][[:lower:]]*)/).delete_if(&:empty?).join("_").downcase
    end

    def singularize
        self.split("_").map { |word| word.chop }.join("_")
    end
   
end

class String
    include ExtendString     
end