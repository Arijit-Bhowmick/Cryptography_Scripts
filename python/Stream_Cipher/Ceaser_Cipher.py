
# Define Global Variable

charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"


def Ceaser_Cipher(process='encode', text=None, key=None):

	# Single function can be used to
	# Encode & Decode Plain-Text & Cipher-Text

	# If PlainText or Key is not provided
	# then it will return None

	if text==None or key==None:
		return ''


	# If User Passes PlainText & Key
	if process=='decode':
		# For Decoding Ceaser Cipher
		key*=-1
		charset_length = 0
	else:
		# For Encoding Ceaser Cipher
		charset_length = len(charset)

	result = ''


	for i in text:
		if (i.upper() not in charset):
			result+=i

		else:

			replacer = charset[charset.index(i.upper())+key-charset_length]

			if i == i.lower():
				result+=replacer.lower()
			else:
				result+=replacer
	return result


# ----------------------------------------------------------------------

key = 6
# Encode PlainText
plain_text = 'Hello Arijit Bhowmick !!!'
print(f"CipherText of {plain_text} having key = {key} => {Ceaser_Cipher('encode',plain_text, key)}")

# Decode CipherText
cipher_text=' Nkrru Gxopoz Hnucsoiq !!!'
print(f"PlainText of {cipher_text} having key = {key} => {Ceaser_Cipher('decode',cipher_text, key)}")
