class Integer
  def random_characters
    l = [('a'..'z'),('A'..'Z'),(0..9)].map{|i| i.to_a}.flatten
    self.times.map{l[rand(l.length)]}.join
  end
end
