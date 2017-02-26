#!/usr/bin/env ruby

require 'securerandom'
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

CODES = {
  "Coins": ['T', 'H'],
  "Dice": [1, 2, 3, 4, 5, 6],
  "D12": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
  "D20": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
  "Hex": %w{0 1 2 3 4 5 6 7 8 9 A B C D E F},
  "Alpha": ('a'..'z').to_a,
  "Bitcoin": "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".split(''),
  "RGB": ["00", "55", "AA", "FF"].repeated_permutation(3).map(&:join).sort,
  "Emoji": File.read('emoji.txt').split(/\n/),
  "Kranzky": File.read('words.txt').split(/\n/),
  "DiceWare": File.read('diceware.wordlist.asc').split(/\n/),
  "EFF DiceWare": File.read('eff_large_wordlist.txt').split(/\n/)
}

SPEED = {
  "Human": 1,
  "Script Kiddie": 1e6,
  "Hacker": 1e9,
  "Spy Agency": 1e12
}

def encode(number, alphabet, replace=[], length=nil)
  base = alphabet.length
  alphabet = alphabet.clone
  symbols = []
  while true
    index = number % base
    if replace.length > 0 && symbols.length > replace.length
      raise "not enough replace symbols"
    end
    symbols << alphabet[index]
    if replace.length > 0
      alphabet[index] = replace[symbols.length - 1]
    end
    number /= base
    break if number == 0 && (length.nil? || symbols.length == length)
  end
  symbols.reverse
end

def decode(symbols, alphabet, replace=[])
  if replace.length > 0 && symbols.length - 1 > replace.length
    raise "not enough replace symbols"
  end
  number = 0
  base = alphabet.length
  symbols.each do |symbol|
    index = alphabet.index(symbol)
    number *= base
    number += index
  end
  number
end

# STEP 1: how guessable do you want your password to be?
#         2 words: a person cannot guess it; good for an IRL code word or wifi password that you need to tell people verbally
#         3 words: good for netflix login or something you need to type using an osk
#         4 words: good for passwords you need to type frequently, such as apple id
#         5 words and up: good for master password for password manager vault
#         recommend 6 words (72-bit) - not guessable by a spy agency in reasonable time
#         can do up to 10 words (120-bit) - not guessable before the heat death of the universe
bits = 72

# what is the largest number
max = 2 ** bits

puts "Entropy: #{bits} bits"
puts "Range: 1 to #{max}"

# STEP 2: how would you like to choose a random number?
# TODO: what type of dice do you have? how many?
# TODO: allow user to roll more than what we've got, then scale the results
#       (roll 5 dice 4 times for instance)
# TODO: use window.crypto.getRandomValues to roll the dice or flip the coins
# TODO: use random.org
# TODO: use actual coins, d6, d12 or d20 dice
number = rand(max)

puts "Number: #{number}"

# STEP 3: what encoding would you like to use?
CODES.each do |name, alphabet|
	base = alphabet.length
	length = Math.log(max, base).round(6).ceil
	code = 
		if name == :"Kranzky"
      base = 4096
      length = Math.log(max, base).round(6).ceil
			encode(number, alphabet[0, 4096], alphabet[4096, 9], length)
		else
			encode(number, alphabet, [], length)
		end
	puts "#{name} (base #{base}, length #{length}): #{code.join(',')}"
	value =
		if name == :"Kranzky"
			decode(code, alphabet[0, 4096], alphabet[4096, 9])
		else
			decode(code, alphabet)
		end
	raise unless number == value
end

# STEP 4: tips for how to memorize and when to update
# TODO: encrypt password and allow user to confirm they remember it
# TODO: what to do if doesn't satisfy password rules
SPEED.each do |name, gps|
  years = (0.5 * max) / (gps * 31556926.08)
  puts "#{name}: #{years} years"
end

# encrypt password
# + generate a long random salt using a cryptographically secure prng
# + prepend the salt to the password and hash with a standard hashing function
# + store the hash and the salt
# + use key stretching to make it slow
# + use bcryptjs or pbkdf2
# users can safely store this encrypted text somewhere
