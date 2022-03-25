class Transportation_Cipher

	def self.generate_matrix(matrix)

		format = ''
		# Generate Matrix Output
		(0..(matrix[1].length-1)).step(1) do |i|

			format += '%-'+(matrix[1][i].to_s.length+1).to_s+'s '
		end


		
		puts '','MATRIX:',''
		(0..(matrix.length-1)).step(1) do |i|
			puts format % matrix[i]
			
			if i<2
				puts format % (('-'*matrix[0].length).chars)
			end
		end

		puts ''
	end


	def self.encoder(plain_text, key, show_matrix='hide')
		
		key_sorted = key.upcase.chars.sort_by{ |key| key}

		key = key.chars

		

		key_matrix = Array.new(key.length,'')

		pt_matrix = Array.new(plain_text.chars.each_slice(key.length).to_a.map(&:join).length){Array.new(key.length, '')}

		# Set Matrix for key elements [KEY_MATRIX]

		(0..(key_sorted.length-1)).step(1) do |i|
			key_matrix[i]=key_sorted.index(key[i].upcase)
			key_sorted[key_sorted.index(key[i].upcase)]=''
		end

		# Set Matrix for Text elements [TEXT_MATRIX]

		marker=0
		(0..(pt_matrix.length-1)).step(1) do |i|
			(0..(pt_matrix[i].length-1)).step(1) do |j|


				if marker!=plain_text.length
					pt_matrix[i][j]=plain_text[marker]
					marker+=1
				end
			end
		end

		# Set Plain_Text into proper matrix

		cipher_text=''
		(0..(key_matrix.length-1)).step(1) do |i|
			(0..(pt_matrix.length-1)).step(1) do |j|
				cipher_text+=pt_matrix[j][key_matrix.index(i)]
			end
		end
		
		# Generate matrix output if
		# show_matrix = 'SHOW'

		if show_matrix.upcase=='SHOW'
			matrix = [key]+[key_matrix]+pt_matrix
			self.generate_matrix(matrix)
		
		end
		return cipher_text


	end


	def self.decoder(cipher_text, key, show_matrix='hide')
		key_sorted = key.upcase.chars.sort_by{ |key| -key}

		key = key.chars

		key_matrix = Array.new(key.length,'')

		# Set Cipher_Text MATRIX Layout
		ct_matrix = cipher_text.chars.each_slice(key.length).to_a

		# Set Matrix for key elements [KEY_MATRIX]

		(0..(key_sorted.length-1)).step(1) do |i|
			key_matrix[i]=key_sorted.index(key[i].upcase)
			key_sorted[key_sorted.index(key[i].upcase)]=''
		end

		# Set Matrix for Text elements [TEXT_MATRIX]
		marker=0
		key_sorted = key_matrix

		(0..(key_matrix.length-1)).step(1) do |i|
			(0..(ct_matrix.length-1)).step(1) do |j|

				if ct_matrix[j][key_matrix.index(i)]==nil
					ct_matrix[j][key_matrix.index(i)]=''
				elsif marker!=cipher_text.length
					ct_matrix[j][key_matrix.index(i)]=cipher_text[marker]
					marker+=1

				end
			end
		end

		# Set cipher text into proper matrix

		plain_text=''
		(0..(ct_matrix.length-1)).step(1) do |i|
			(0..(ct_matrix[i].length-1)).step(1) do |j|
				plain_text+=ct_matrix[i][j]
			end
		end
		
		# Generate matrix output if
		# show_matrix = 'SHOW'
		if show_matrix.upcase=='SHOW'
			matrix = [key]+[key_matrix]+ct_matrix
			self.generate_matrix(matrix)
		
		end
		return plain_text
	end
end

# --------------------------------

plain_text = 'Arijit Bhowmick 123'
cipher_text = 'im3jw2 cABkio1tirh '
key = 'syS41x4'

puts "Plain Text => #{plain_text}"
puts "Key => #{key}"
puts "Cipher Text => #{Transportation_Cipher.encoder(plain_text, key, 'show')}"
puts '*'*30
puts "Cipher Text => #{cipher_text}"
puts "Key => #{key}"
puts "Cipher Text => #{Transportation_Cipher.decoder(cipher_text, key, 'show')}"
