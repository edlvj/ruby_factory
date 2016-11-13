class Factory
    
    def self.new(*attrs, &block)
      Class.new do
        attr_accessor *attrs
      
        define_method :initialize do |*attrs_params|
          attrs.each_with_index do |attr ,index|
            self.send("#{attr}=",attrs_params[index])
          end
        end
      
        define_method :[] do |attr|
          attr.is_a?(Integer)? send("#{attrs[attr]}") : send(attr)
        end
      
        class_eval(&block) if block_given?
      end
    end  
    
end    

Customer = Factory.new(:name, :address) do
  def greeting
    "Hello #{name}!"
  end
end

joe = Customer.new('Joe Smith', '123 Maple, Anytown NC', 12345)

puts joe.name
puts joe['name']
puts joe[:name]
puts joe[0]

puts Customer.new('Dave', '123 Main').greeting