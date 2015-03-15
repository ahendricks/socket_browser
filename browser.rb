require 'socket'
require 'json'

hostname = 'localhost'
port = 2000

puts "Choose request type. 1 for GET, 2 for POST:"
request_type = gets.chomp.to_i

if request_type == 1
	path = '/index.html'
	request = "GET #{path} HTTP/1.0\r\n\r\n"
elsif request_type == 2
	path = '/thanks.html'
	
	puts "Enter your name:"
	name = gets.chomp
	puts "Enter your email:"
	email = gets.chomp
	puts "Enter your age:"
	age = gets.chomp

	request_hash = { user: { name: name, email: email, age: age } }.to_json
	request = "POST #{path} HTTP/1.0\r\n\r\n#{request_hash}"
else
	puts "Action not recognized."
	exit
end

s = TCPSocket.open(hostname, port)
s.print(request)
response = s.read

header,body = response.split("\r\n\r\n", 2)

print body
s.close