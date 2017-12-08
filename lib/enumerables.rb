#lib/enumerables.rb
module Enumerable

  def my_each
    return enum_for(:my_each) unless block_given?
    i=0
    self.size.times do
      yield(self[i])
      i+=1
    end
    self
  end

  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?
    i=0
    self.size.times do
      yield([self[i], i])
      i+=1
    end
    self
  end

  def my_select
    return enum_for(:my_select) unless block_given?
    result = []
    self.my_each do |x|
      result << x if yield(x)
    end
    result
  end

  def my_all?
    return enum_for(:my_all) unless block_given?
    result = true
    self.my_each do |x|
      result = result && yield(x)
    end
    result
  end

  def my_any?
    return enum_for(:my_any?) unless block_given?
    result = false
    self.my_each do |x|
      result = result || yield(x)
    end
    result
  end

  def my_none?
    return enum_for(:my_none?) unless block_given?
    result = false
    self.my_each do |x|
      result = result || yield(x)
    end
    !result
  end

  def my_count
    return enum_for(:my_count) unless block_given?
    result = 0
    self.my_each do |x|
      result += 1 if yield(x)
    end
    result
  end

  def my_map (my_proc = nil)
    return enum_for(:my_map) unless block_given?
    result = []
    self.my_each do |x|
      result << my_proc.call(x) if my_proc != nil
      result << yield(x) if (my_proc == nil)
    end
    result
  end

  def my_inject
    return enum_for(:my_inject) unless block_given?
    array = self.dup
    accumulator = array.shift
    array.my_each do |x|
      accumulator = yield(accumulator, x)
    end
    accumulator
  end

  def multiply_els(input)
    input.my_inject {|product, x| product*x}
  end

end
