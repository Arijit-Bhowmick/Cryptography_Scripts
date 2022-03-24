class Transportation_Cipher

	def self.encoder(plain_text, key, show_matrix='hide')
		key = key.chars
		key_sorted = key.sort_by{ |key| key}

		key_matrix = Array.new(key.length,'')

		pt_matrix = Array.new(((plain_text.length-plain_text.length%key.length)/key.length)+1){Array.new(key.length, '')}

		(0..(key_sorted.length-1)).step(1) do |i|
			key_matrix[i]=key_sorted.index(key[i])
			key_sorted[key_sorted.index(key[i])]=''
		end

		marker=0
		(0..(pt_matrix.length-1)).step(1) do |i|
			(0..(pt_matrix[i].length-1)).step(1) do |j|


				if marker!=plain_text.length
					pt_matrix[i][j]=plain_text[marker]
					marker+=1
				end
			end
		end

		cipher_text=''
		(0..(key_matrix.length-1)).step(1) do |i|
			(0..(pt_matrix.length-1)).step(1) do |j|
				cipher_text+=pt_matrix[j][key_matrix.index(i)]
			end
		end
		
		matrix = [key]+[key_matrix]+pt_matrix
		
		format = ''
		# Generate Matrix Output
		(0..(matrix[1].length-1)).step(1) do |i|

			format += '%-'+(matrix[1][i].to_s.length+1).to_s+'s '
		end


		if show_matrix.upcase=='SHOW'
			puts '','MATRIX:',''
			(0..(matrix.length-1)).step(1) do |i|
				if i<2
					puts format % matrix[i]
					puts format % (('-'*matrix[0].length).chars)

				else
					puts format % matrix[i]
				end
			end

			puts ''
		end
		return cipher_text


	end
end

# --------------------------------

plain_text = 'Arijit Bhowmick'
key = 'HelL0 W0RlD'

puts "Plain Text => #{plain_text}"
puts "Key => #{key}"
puts "Cipher Text => #{Transportation_Cipher.encoder(plain_text, key, 'show')}"