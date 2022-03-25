class RailFence_Cipher
    # Encoder & Decoder functions
    # for RailFence_Cipher


    def self.generate_matrix(matrix)

        format = ''
        # Generate Matrix Output
        (0..(matrix[1].length-1)).step(1) do |i|

            format += '%-'+(matrix[1][i].to_s.length+1).to_s+'s '
        end


        
        puts '','MATRIX:',''
        (0..(matrix.length-1)).step(1) do |i|
            puts format % matrix[i]
        end

        puts ''
    end


    def self.encoder(plain_text, key, show_matrix='hide', offset=0)

        # RailFence Encoder Function
        # Considering offset=0

        matrix = Array.new(key) {Array.new(plain_text.length, '')}

        # to find the direction
        dir_down = false
        row, col = 0, 0

        (0..(plain_text.length-1)).step(1) do |i|   
            # check the direction of flow
            # reverse the direction if we've just
            # filled the top or bottom rail
            if (row == 0) or (row == key - 1)
                dir_down = (not dir_down)
            end
            # fill the corresponding alphabet
            matrix[row][col] = plain_text[i]
            col += 1

         
            # find the next row using
            # direction flag
            if dir_down
                row += 1
            else
                row -= 1
            end
        end

        cipher_text = '' # Used as CipherText (str)

        (0..(key-1)).step(1) do |i|   

            #for j in range(len(text)):
            (0..(plain_text.length-1)).step(1) do |j| 
                if matrix[i][j] != ''
                    cipher_text.concat(matrix[i][j])
                end
            end
        end

        # Generate matrix output if
        # show_matrix = 'SHOW'
        if show_matrix.upcase=='SHOW'
            self.generate_matrix(matrix)
        end

        return cipher_text
    end

    def self.decoder(cipher_text, key, show_matrix='hide', offset=0)

        # RailFence Decoder Function
        # Considering offset=0

        row_range = 0..key
        column_range = 0..cipher_text.length

        matrix = Array.new(key) {Array.new(cipher_text.length, '')}

        dir_down = 0
        row, col = 0, 0

        (0..(cipher_text.length-1)).step(1) do |i|   
            if row == 0
                dir_down = true
            elsif row == (key - 1)
                dir_down = false
            end

            # place the marker
            matrix[row][col] = '\m'
            col += 1
             
            # find the next row
            # using direction flag
            if dir_down
                row += 1
            else
                row -= 1
            end
        end
            # now we can construct the
            # fill the rail matrix
        marker = 0
        (0..(key-1)).step(1) do |i|   

            (0..(cipher_text.length-1)).step(1) do |j|   

                if ((matrix[i][j] == '\m') and (marker < cipher_text.length))
                    matrix[i][j] = cipher_text[marker]
                    marker += 1
                end
            end
        end

        # now read the matrix in
        # zig-zag manner to construct
        # the resultant text

        plain_text = '' # Used as PlainText (str)
        row, col = 0, 0

        (0..(cipher_text.length-1)).step(1) do |i| 
             
            # check the direction of flow
            if row == 0
                dir_down = true
            elsif row == key-1
                dir_down = false 
            end
            # place the marker
            if (matrix[row][col] != '\m')
                plain_text.concat(matrix[row][col])
                col += 1 
            end   
            # find the next row using
            # direction flag
            if dir_down
                row += 1
            else
                row -= 1
            end
        end

        # Generate matrix output if
        # show_matrix = 'SHOW'
        if show_matrix.upcase=='SHOW'
            self.generate_matrix(matrix)
        end

        return plain_text
    end
end



# Encode text
plain_text = "Hello World !!!"
key = 3
puts "CipherText of #{plain_text} having key = #{key} => #{RailFence_Cipher.encoder(plain_text,key, 'show')}"


# Decode Cipher
cipher_text = "Hor!el ol !lWd!"

puts "PlainText of #{cipher_text} having key = #{key} => #{RailFence_Cipher.decoder(cipher_text,key, 'show')}"



