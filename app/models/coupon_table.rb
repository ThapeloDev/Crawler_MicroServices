class CouponTable < ActiveRecord::Base
  include Mongoid::Document
  field :title, type: String
  field :page, type: String
  field :percent_discount, type: String


  def solution(n, s)
    abc_col, defg_col, hjk_col = init_hash(n)
    data_after = fill_hash(s, abc_col, defg_col, hjk_col)
    number = count(data_after)    
  end

  def init_hash n
    abc_col = []
    n.times do |row|
      abc_col << {a: nil, b: nil, c: nil}
    end

    defg_col = []
    n.times do |row|
      defg_col << {d: nil, e: nil, f: nil, g: nil}
    end

    hjk_col = []
    n.times do |row|
      hjk_col << {h: nil, j: nil, k: nil}
    end

    [abc_col, defg_col, hjk_col]    

  end

  def fill_hash s, abc_col, defg_col=nil, hjk_col=nil
    
    data_array = s.split(" ")
    [abc_col, defg_col, hjk_col].compact.each do |row|
      row.each_with_index do |value, index|
        
        value.each do |k, v|
          
          data_array_process = data_array.select{|i| i if i.to_i == index+1}
          data_array_process.each do |element|
            if element[1].downcase == k.to_s
              value[k] = 1
            end
          end
        end
      end
    end


    [abc_col, defg_col, hjk_col]
  end

  def count data
    count = 0
    data.each_with_index do |array, index|
      if index == 0
        array.each do |row|
          if row[:a] == nil && row[:b] == nil && row[:c] == nil
            count += 1
          end
        end
      elsif index == 1
        array.each do |row|
          if (row[:d] == nil && row[:e] == nil && row[:f] == nil) ||
            (row[:e] == nil && row[:f] == nil && row[:g] == nil)
            count += 1
          end
        end

      elsif index == 2
        array.each do |row|
          if row[:h] == nil && row[:j] == nil && row[:k] == nil
            count += 1
          end
        end
      end
    end
    count
  end

  def solution2(n,s)
    s = s.split(" ").sort
    result = {}

    n.times do |soday|
      soday += 1
      c = s.select{|x| x.to_i == soday}
      hash = {}
      hash[0] = c.select{|x| ["A", "B", "C"].include? x.scan(/\D/).first}
      hash[1] = c.select{|x| ["D", "E", "F", "G"].include? x.scan(/\D/).first}
      hash[2] = c.select{|x| ["H", "J", "K"].include? x.scan(/\D/).first}
      day1 = (3 - hash[0].length) / 3
      day2 = (4 - hash[1].length) / 3 if hash[1].length == 0 || hash[1].select{|x| (x.scan(/\D/).first == "D" || x.scan(/\D/).first == "G")}.length > 0

      day3 = (3 - hash[2].length) / 3
      result["#{soday}"] = [day1.to_i , day2.to_i, day3.to_i].inject(:+)
    end
    return result.values.inject(:+)
  end


  def check
    puts a = Time.now
    solution2(3, '1D 2G 4H 1F 3G 2J 1K 1A 2B 3C 3A')
    puts Time.now - a

  end
end
  