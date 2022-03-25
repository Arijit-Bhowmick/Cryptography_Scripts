class RailFence_Cipher:
    # Encoder & Decoder functions
    # for RailFence_Cipher

    def print_table(table):
	    longest_cols = [
	        (max([len(str(row[i])) for row in table]) + 1)
	        for i in range(len(table[0]))
	    ]
	    row_format = "".join(["{:>" + str(longest_col) + "}" for longest_col in longest_cols])
	    for row in table:
	        print(row_format.format(*row))

    def encoder(plain_text, key, show_matrix='hide', offset=0):

        # RailFence Encoder Function
        # Considering offset=0


        matrix = []
        for i in range(key):matrix+=[['']*len(plain_text)]

        # to find the direction
        dir_down = False
        row, col = 0, 0
 
        for i in plain_text:
            # check the direction of flow
            # reverse the direction if we've just
            # filled the top or bottom rail
            if (row == 0) or (row == key - 1):
                dir_down = (not dir_down)

            # fill the corresponding alphabet
            matrix[row][col] = i
            col += 1

         
            # find the next row using
            # direction flag
            if dir_down:
                row += 1
            else:
                row -= 1


        cipher_text = '' # Used as CipherText (str)

        for i in range(key):
            for j in range(len(plain_text)):
                if matrix[i][j] != '':
                    cipher_text+=matrix[i][j]

        # Generate matrix output if
        # show_matrix = 'SHOW'

        if show_matrix.upper()=='SHOW':
        	RailFence_Cipher.print_table(matrix)

        return cipher_text

    def decoder(cipher_text, key, show_matrix='hide', offset=0):

        # RailFence Decoder Function
        # Considering offset=0

        matrix = []
        for i in range(key):matrix+=[['']*len(cipher_text)]

        dir_down = 0
        row, col = 0, 0

        for i in range(len(cipher_text)):
            if row == 0:
                dir_down = True
            elif row == (key - 1):
                dir_down = False
            

            # place the marker
            matrix[row][col] = '\m'
            col += 1
             
            # find the next row
            # using direction flag
            if dir_down:
                row += 1
            else:
                row -= 1

            # now we can construct the
            # fill the rail matrix
        marker = 0 
        for i in range(key):
            for j in range(len(cipher_text)):
                if ((matrix[i][j] == '\m') and (marker < len(cipher_text))):
                    matrix[i][j] = cipher_text[marker]
                    marker += 1


        # now read the matrix in
        # zig-zag manner to construct
        # the resultant text

        plain_text = '' # Used as PlainText (str)
        row, col = 0, 0

        for i in range(len(cipher_text)):
            # check the direction of flow
            if row == 0:
                dir_down = True
            elif row == key-1:
                dir_down = False 
            

            # place the marker
            if (matrix[row][col] != '\m'):
                
                plain_text+=matrix[row][col]
                col += 1 
               
            # find the next row using
            # direction flag
            if dir_down:
                row += 1
            else:
                row -= 1

        # Generate matrix output if
        # show_matrix = 'SHOW'

        if show_matrix.upper()=='SHOW':
        	RailFence_Cipher.print_table(matrix)

        return plain_text



# Encode text
plain_text = "Arijit Bhowmick :P"
key = 3
print(f"CipherText of {plain_text} having key = {key} => {RailFence_Cipher.encoder(plain_text, key, 'show')}")


# Decode Cipher
cipher_text = "Aihi:rjtBomc Pi wk"

print(f"PlainText of {cipher_text} having key = {key} => {RailFence_Cipher.decoder(cipher_text, key, 'show')}")




