module AfterExecute

	def after(*names)
        names.each do |name|
			m = instance_method(name)
			define_method(name) do |*args, &block|  
				m.bind(self).(*args, &block)
				yield
			end
        end
    end

end