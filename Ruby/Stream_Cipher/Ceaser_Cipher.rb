
# Define Global Variable

$charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"


def Ceaser_Cipher(process='encode', text, key)

	# Single function can be used to
	# Encode & Decode Plain-Text & Cipher-Text

	if process=='decode'
		# For Decoding Ceaser Cipher
		key*=-1
		charset_length = 0
	else
		# For Encoding Ceaser Cipher
		charset_length = $charset.length
	end

	result = ''

	(0..(text.length-1)).step(1) do |i|

		if not $charset.include? text[i].upcase
			result.concat(text[i])

		else

			replacer = $charset[$charset.index(text[i].upcase)+key-charset_length]

			if text[i] == text[i].downcase
				result.concat(replacer.downcase)
			else
				result.concat(replacer)
			end
		end
	end
	return result
end


# ----------------------------------------------------------------------

key = 6
# Encode PlainText
plain_text = 'Hello Arijit Bhowmick !!!'
puts "CipherText of #{plain_text} having key = #{key} => #{Ceaser_Cipher('encode',plain_text, key)}"

# Decode CipherText
cipher_text=' Nkrru Gxopoz Hnucsoiq !!!'
puts "PlainText of #{cipher_text} having key = #{key} => #{Ceaser_Cipher('decode',cipher_text, key)}"