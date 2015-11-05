class Tictactoe
	def initialize
		@state = [].fill(0,9) { |_| nil}
		@player = :P1
		main
	end

	# private
	def rows
		rows = []
		for i in 0..2
			rows << @state.slice(i*3,3)
		end
		return rows
	end

	def columns
		columns = []
		for i in 0..2
			column = []
			for k in 0..2
				column << @state[i + k*3]
			end
			columns << column
		end
		return columns
	end

	def diagonals
		diagonals = []
		forward = []
		for i in 0..2
			forward << @state[i*3 + i]
		end
		diagonals.push(forward)
		backward = []
		for i in 0..2
			backward << @state[i*2 + 2]
		end
		diagonals.push(backward)
		return diagonals
	end

	def win_con(three)
		three.all? {|x| x == @player}
	end

	def victory?
		bools = (rows + columns + diagonals).map {|x| win_con(x)}
		return bools.any? {|x| x == true}
	end

	def board_full?
		!(rows + columns + diagonals).flatten.any? {|x| x == nil}
	end

	def print_row(r)
		to_put = ""
		r.each {|e| if e == nil
						to_put = to_put + "* "
					elsif e == :P1
						to_put = to_put + "o "
					else
						to_put = to_put + "x "
					end}
		puts to_put
	end

	def print_state
		rows.each {|r| print_row(r)}
	end

	def toggle_player
		if @player == :P1
			@player = :P2
		else
			@player = :P1
		end
	end

	def main
		running = true
		while running
			print_state
			puts "#{@player}'s turn: Where would you like to go? (1-9)"
			input = gets
			if @state[input.to_i-1] != nil
				puts "Someone already went there. Try again. \n"
				next
			else
				@state[input.to_i-1] = @player
			end
			if victory?
				print_state
				puts "Game over. #{@player} wins!"
				running = false
			end
			if board_full?
				print_state
				puts "Game over. Nobody wins."
				running = false
			end
			toggle_player
		end
	end
end
