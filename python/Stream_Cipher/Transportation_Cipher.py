class Transportation_Cipher:

	def print_table(table):
	    longest_cols = [
	        (max([len(str(row[i])) for row in table]) + 1)
	        for i in range(len(table[0]))
	    ]
	    row_format = "".join(["{:>" + str(longest_col) + "}" for longest_col in longest_cols])

	    print('MATRIX:\n')
	    for row_num in range(len(table)):
	    	print(row_format.format(*table[row_num]))
	    	if row_num<2:
	    		print (row_format.format(*(['-']*len(table[row_num]))))
	    print()


	def encoder(plain_text, key, show_matrix='hide'):
		
		key_sorted = list(key.upper())
		key_sorted.sort()

		key = list(key)

		key_matrix = [""]*len(key)

		# Get the total Number of columns required
		# for pt_matrix
		marker=0
		pre_pt_matrix=[]
		for i in range (len(key),len(plain_text),len(key)):pre_pt_matrix+=[plain_text[marker:i]];marker=i
		pre_pt_matrix+=[plain_text[marker:]]


		pt_matrix = []

		for i in range(len(pre_pt_matrix)):pt_matrix+=[['']*len(key)]

		# Set Matrix for key elements [KEY_MATRIX]

		for i in range (len(key_sorted)):
			key_matrix[i]=key_sorted.index(key[i].upper())
			key_sorted[key_sorted.index(key[i].upper())]=''


		# Set Matrix for Text elements [TEXT_MATRIX]

		marker=0
		for i in range (len(pt_matrix)):
			for j in range(len(pt_matrix[i])):

				if marker!=len(plain_text):
					pt_matrix[i][j]=plain_text[marker]
					marker+=1

		# Set Plain_Text into proper matrix

		cipher_text=''
		for i in range (len(key_matrix)):
			for j in range (len(pt_matrix)):
				cipher_text+=pt_matrix[j][key_matrix.index(i)]
		
		# Generate matrix output if
		# show_matrix = 'SHOW'

		if show_matrix.upper()=='SHOW':
			matrix = [key]+[key_matrix]+pt_matrix
			Transportation_Cipher.print_table(matrix)
		

		return cipher_text


	def decoder(cipher_text, key, show_matrix='hide'):
		key_sorted = list(key.upper())
		key_sorted.sort()

		key = list(key)

		key_matrix = [""]*len(key)

		# Set Cipher_Text MATRIX Layout
		marker=0
		ct_matrix=[]
		for i in range (len(key),len(cipher_text),len(key)):ct_matrix+=[['\n']*len(cipher_text[marker:i])];marker=i
		ct_matrix+=[['\n']*len(cipher_text[marker:])]
		ct_matrix[-1]+=['']*(len(key)-len(cipher_text[marker:]))


		# Set Matrix for key elements [KEY_MATRIX]

		for i in range (len(key_sorted)):
			key_matrix[i]=key_sorted.index(key[i].upper())
			key_sorted[key_sorted.index(key[i].upper())]=''


		# Set Matrix for Cipher Text elements [CipherText_MATRIX]
		marker=0
		key_sorted = key_matrix

		for i in range(len(key_matrix)):
			for j in range(len(ct_matrix)):
				if marker!=len(cipher_text) and ct_matrix[j][key_matrix.index(i)]=='\n':
					ct_matrix[j][key_matrix.index(i)]=cipher_text[marker]
					marker+=1

		# Set cipher text into proper matrix

		plain_text=''
		for i in range(len(ct_matrix)):
			for j in range(len(ct_matrix[i])):
				plain_text+=ct_matrix[i][j]
		
		# Generate matrix output if
		# show_matrix = 'SHOW'

		if show_matrix.upper()=='SHOW':
			matrix = [key]+[key_matrix]+ct_matrix
			Transportation_Cipher.print_table(matrix)


		return plain_text

# --------------------------------

plain_text = 'Arijit Bhowmick :)'
cipher_text = 'imjw) cABkio:tirh '
key = 'syS41x4'

print(f"""Plain Text => {plain_text}
Key => {key}
Cipher Text => {Transportation_Cipher.encoder(plain_text, key, 'show')}
{'*'*30}""")

print(f"""Cipher Text => {cipher_text}
Key => {key}
Cipher Text => {Transportation_Cipher.decoder(cipher_text, key, 'show')}""")