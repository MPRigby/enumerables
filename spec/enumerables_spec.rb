#spec/enumerables_spec.rb
require "enumerables"

describe Enumerable do

  let(:input_array) {[5, 4, 3, 2, 1, 0]}
  let(:input_hash) {{monkey: "George", lizard: "Lizzie", wolf: "Ralph", rhino: "Boris", lobster: "Ruby"}}

  describe ".my_each" do
    context "given no block" do
      it "returns an enumerator" do
        expect(input_array.my_each).to be_instance_of(Enumerator)
      end
    end
    context "given an array and a block" do
      it "executes the block for each array element" do
        expect{input_array.my_each {|x| print x}}.to output("543210").to_stdout
      end
      it "does not overwrite input array" do
        expect(input_array.my_each {|x| x**2}).to eql(input_array)
      end
      #it "iterates over a hash, but does not overwrite" do
      #  expect(input_hash.my_each {|key, value| value.reverse()}).to eql(input_hash)
      #end
    end
  end

  describe ".my_each_with_index" do
    context "given no block" do
      it "returns an enumerator" do
        expect(input_array.my_each_with_index).to be_instance_of(Enumerator)
      end
    end
    context "given an array and a block which requires the array index" do
      it "executes the block for each array element" do
        expect{input_array.my_each_with_index {|x, i| print "v=#{x} i=#{i}, "}}.to output("v=5 i=0, v=4 i=1, v=3 i=2, v=2 i=3, v=1 i=4, v=0 i=5, ").to_stdout
      end
      it "does not overwrite input array" do
        expect(input_array.my_each_with_index {|x, i| x**i}).to eql(input_array)
      end
    end
  end

  describe ".my_select" do
    context "given no block" do
      it "returns an enumerator" do
        expect(input_array.my_select).to be_instance_of(Enumerator)
      end
    end
    context "given an array and a block containing a boolean expression" do
      it "returns the elements for which the boolean expression returns true" do
        expect(input_array.my_select {|x| x%2==0}).to eql([4, 2, 0])
      end
      it "does not overwrite input array" do
        input_array.my_select {|x| x==2}
        expect(input_array).to eql([5, 4, 3, 2, 1, 0])
      end
    end
  end

  describe ".my_all?" do
    context "given no block" do
      it "returns an enumerator" do
        expect(input_array.my_all?).to be_instance_of(Enumerator)
      end
    end
    context "given an array and a block containing a boolean expression" do
      it "returns true if each element satisfies the boolean expression" do
        expect(input_array.my_all? {|x| x<10}).to eql(true)
      end
      it "returns false if any element does not satisfy the boolean expression" do
        expect(input_array.my_all? {|x| x<5}).to eql(false)
      end
      it "does not overwrite input array" do
        input_array.my_all? {|x| x<10}
        expect(input_array).to eql([5, 4, 3, 2, 1, 0])
      end
    end
  end

  describe ".my_any?" do
    context "given no block" do
      it "returns an enumerator" do
        expect(input_array.my_any?).to be_instance_of(Enumerator)
      end
    end
    context "given an array and a block containing a boolean expression" do
      it "returns true if any element satisfies the boolean expression" do
        expect(input_array.my_any? {|x| x==2}).to eql(true)
      end
      it "returns false if no element satisfies the boolean expression" do
        expect(input_array.my_any? {|x| x>6}).to eql(false)
      end
      it "does not overwrite input array" do
        input_array.my_any? {|x| x<10}
        expect(input_array).to eql([5, 4, 3, 2, 1, 0])
      end
    end
  end

  describe ".my_none?" do
    context "given no block" do
      it "returns an enumerator" do
        expect(input_array.my_none?).to be_instance_of(Enumerator)
      end
    end
    context "given an array and a block containing a boolean expression" do
      it "returns true only if no element satisfies the boolean expression" do
        expect(input_array.my_none? {|x| x==8}).to eql(true)
      end
      it "returns false if any element satisfies the boolean expression" do
        expect(input_array.my_none? {|x| x==3}).to eql(false)
      end
      it "does not overwrite input array" do
        input_array.my_none? {|x| x>10}
        expect(input_array).to eql([5, 4, 3, 2, 1, 0])
      end
    end
  end

  describe ".my_count" do
    context "given no block" do
      it "returns an enumerator" do
        expect(input_array.my_count).to be_instance_of(Enumerator)
      end
    end
    context "given an array and a block containing a boolean expression" do
      it "counts the number of elements which satisfy the boolean expression" do
        expect(input_array.my_count {|x| x<=3}).to eql(4)
        expect(input_array.my_count {|x| x>8}).to eql(0)
      end
      it "does not overwrite input array" do
        input_array.my_none? {|x| x>10}
        expect(input_array).to eql([5, 4, 3, 2, 1, 0])
      end
    end
  end

  describe ".my_map" do
    context "given no block or proc" do
      it "returns an enumerator" do
        expect(input_array.my_map).to be_instance_of(Enumerator)
      end
    end
    context "given an array and a block" do
      it "executes the block for each array element, and returns the results in a new array" do
      expect(input_array.my_map {|x| x**2}).to eql([25, 16, 9, 4, 1, 0])
      end
      it "does not overwrite input array" do
        input_array.my_map {|x| x**2}
        expect(input_array).to eql([5, 4, 3, 2, 1, 0])
      end
    end
    context "given an array and a proc" do
      it "executes the proc for each array element, and returns the results in a new array" do
        my_proc = Proc.new {|x| x**2}
        expect(input_array.my_map(&my_proc)).to eql([25, 16, 9, 4, 1, 0])
      end
    end
=begin
    context "given an array, a block, and a proc" do
      it "executes the proc for each array element, ignores the block" do
        my_proc = Proc.new {|x| x**2}
        expect(input_array.my_map(&my_proc) {|x| x**4}).to eql([25, 16, 9, 4, 1, 0])
      end
    end
=end
  end

  describe ".my_inject" do
    context "given no block" do
      it "returns an enumerator" do
        expect(input_array.my_inject).to be_instance_of(Enumerator)
      end
    end
    context "given an array and a block with two variables" do
      it "uses the first variable as an accumulator and performs the operation in the block for each element" do
        expect(input_array.my_inject {|sum, x| sum + x}).to eql(15)
        expect(input_array.my_inject {|product, x| product * x}).to eql(0)
        expect([10, 9, 8, 7, 6, 5, 4].my_inject {|product, x| product * x}).to eql (604800)
      end
      it "does not overwrite input array" do
        input_array.my_inject {|product, x| product * x}
        expect(input_array).to eql([5, 4, 3, 2, 1, 0])
      end
    end
  end



end
