class Game
	attr_accessor :board
	attr_accessor :player1
	attr_accessor :player2
	attr_accessor :current_player


	def initialize
		board_array=[]
		i=0
		n=0

		6.times do
			i+=1
			7.times do
				n+=1
				board_array << [i,n,nil]
			end
			n=0
		end

		@board=board_array
		p2="\u26AA"
		p1="\u26AB"
		@player1=p1
		@player2=p2
		@current_player=@player1
	end

	def draw_board
		i=0
		7.times do
			print " _ "
		end
		print "\n"
		6.times do
			7.times do
				if @board[i][2]==nil
					print "|_|"
				else
					print "|#{@board[i][2]}|"
				end
				i+=1
			end
			print "\n"
		end
	end



	

	def check_for_win


		#check for horizontal win		
		42.times do |i|

			if board[i][2]==current_player

				found=1
				n=i+1
				3.times do
				if n>41
					n=0
					found=-3
				end
					if board[n][2]==current_player && board[n][0]==board[i][0]
						found+=1
					end
					n+=1
				end
				if found==4
					return true
				end
				
			end
			
		end

		#check for vertical win
		42.times do |i|
			if board[i][2]==current_player
				found=1
				#since we're checking columns, we increment by 7 to get one row up for checking
				n=i+7

				#if we exceed the bounds of the game board, then we reset our checker to the initial square
				#and we set the found count to a negative to ensure that we can't return a misleading win
				if n>41
					n=0
					found=-3
				end
				3.times do
					if n>41
						n=0
						found=-3
					end
					if board[n][2]==current_player && board[n][1]==board[i][1]
						found+=1
					end
					n+=7

				end
				if found==4
					return true
				end
			end
		end

		#check for diagonal win from left top to bottom right
		#this is going to be the same as column, except we're increasing by 8 to get a diagonal
		42.times do |i|
			if board[i][2]==current_player
				found=1

				n=i+8

				if n>41
					n=0
					found=-3
				end
				3.times do
					if n>41
						n=0
						found=-3
					end

					#check to make sure the square has the same player's piece and that the square is only
					#one column ahead
					if board[n][2]==current_player && board[n-8][1]+1==board[n][1]
						found+=1
					end
					n+=8

				end
				if found==4
					return true
				end
			end
		end

		def check_for_draw
			if board.all? {|i| i[2]!=nil}
				return true
			end
			return false
		end



		#check for win from bottom left to top right diagonal. It's basically the same, except
		#for each check we increase by 6 instead of 8. We also have to check to make sure that
		#each successive column is decreased by one as we go down the rows.


		42.times do |i|
			if board[i][2]==current_player
				found=1

				n=i+6

				if n>41
					n=0
					found=-3
				end
				3.times do
					if n>41
						n=0
						found=-3
					end

						#check to make sure the square has the same player's piece and that the square is only
						#one column ahead
					if board[n][2]==current_player && board[n-6][1]-1==board[n][1]
						found+=1
					end
					n+=6

				end
				if found==4
					return true
				end
			end
		end

		return false

	end

	def place_piece(column)


		unless (1..7).include? column
			return false
		end

		column-=1
		i=5
		until i<0
			array_number=i*7+column
			i-=1
			if board[array_number][2]==nil
				board[array_number][2]=current_player
				return true
			end

		end
		return false
	end


	def self.play_game
		puts "Welcome to Connect Four!"
		while true
			new_game=Game.new
			puts "New Game!"
			over=false
			winner=nil
			draw=false
			until over
				new_game.draw_board
				move=false

				until move
					if new_game.current_player==new_game.player1
						puts "It is player 1's turn"
					else
						puts "It is player 2's turn"
					end
					puts "Choose an open column to place a piece in"
					number=gets.chomp.to_i
					move=new_game.place_piece(number)
				end
				if new_game.check_for_win || new_game.check_for_draw
					over=true
					if new_game.check_for_win
						if new_game.current_player==new_game.player1
							winner="player 1"
						else
							winner="player 2"
						end
					else
						draw=true
					end
				end

				if new_game.current_player==new_game.player1
					new_game.current_player=new_game.player2
				else
					new_game.current_player=new_game.player1
				end
			end

			new_game.draw_board

			if winner
				puts "The winner is #{winner}!"
			else
				puts "It's a draw!"
			end
		end
	end

end