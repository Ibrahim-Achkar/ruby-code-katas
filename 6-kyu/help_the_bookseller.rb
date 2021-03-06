# A bookseller has lots of books classified in 26 categories
# labeled A, B, ... Z. Each book has a code c of 3, 4, 5 or more characters.
# The 1st character of a code is a capital letter which defines the book category.

# In the bookseller's stocklist each code c is followed by a space and by a positive integer n
#  (int n >= 0) which indicates the quantity of books of this code in stock.

# For example an extract of a stocklist could be:

# L = {"ABART 20", "CDXEF 50", "BKWRK 25", "BTSQZ 89", "DRTYM 60"}.
# or
# L = ["ABART 20", "CDXEF 50", "BKWRK 25", "BTSQZ 89", "DRTYM 60"] or ....
# You will be given a stocklist (e.g. : L) and a list of categories in capital letters e.g :

# M = {"A", "B", "C", "W"}
# or
# M = ["A", "B", "C", "W"] or ...
# and your task is to find all the books of L with codes belonging to each category of M
#  and to sum their quantity according to each category.

# For the lists L and M of example you have to return the string (in Haskell/Clojure/Racket a list of pairs):
# (A : 20) - (B : 114) - (C : 50) - (W : 0)
# where A, B, C, W are the categories, 20 is the sum of the unique book of category A,
# 114 the sum corresponding to "BKWRK" and "BTSQZ", 50 corresponding to "CDXEF" and
# 0 to category 'W' since there are no code beginning with W.

# If L or M are empty return string is "" (Clojure and Racket should return an empty array/list instead).

# Note:
# In the result codes and their values are in the same order as in M.

def stockList1(listOfArt, listOfCat)
  hash = {}
  string = ''

  listOfCat.each do |cat|
    listOfArt.each do |art|
      hash[cat] = (hash[cat] || 0)
      hash[cat] = hash[cat] + art.split(' ')[1].to_i if cat == art[0]
    end
  end
  hash.each { |key, value| string.concat("(#{key} : #{value}) - ") }
  string[0...-3]
end

p stockList1(['ABAR 200', 'CDXE 500', 'BKWR 250', 'BTSQ 890', 'DRTY 600'], %w[A B])
# "(A : 200) - (B : 1140)"

# other solutions
def stockList2(stock_list, categories)
  return '' if stock_list.empty? || categories.empty?

  quantities = Hash.new(0)
  stock_list.each_with_object(quantities) do |item, quantities|
    code, quantity = item.split(' ')
    quantities[code[0]] += quantity.to_i
  end

  categories.map { |category| "(#{category} : #{quantities[category]})" }.join(' - ')
end

def stockList3(l, m)
  return '' if l.empty? || m.empty?

  result = []
  m.each do |item|
    r = l.select { |c| c =~ /^#{item}/ }.collect { |z| z.split(' ').last.to_i }.reduce(:+)
    result << "(#{item} : #{r || 0})"
  end

  result.join(' - ')
end
