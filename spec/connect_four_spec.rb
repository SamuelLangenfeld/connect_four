require 'connect_four.rb'

describe Game do 
	before do
		@new_game=Game.new
	end




	describe ".initialize" do
		it "creates an array for the board state" do
			expect(@new_game.board).to be_instance_of(Array)
		end
		it "has an array of blank values" do
			expect(@new_game.board.all? {|i| i[2]==nil}).to eql(true)
		end

		it "has the right number of cells" do
			expect(@new_game.board.size).to eql(42)

		end

		it "has 2 players" do
			expect(@new_game.player1.nil?).to eql(false)
			expect(@new_game.player2.nil?).to eql(false)
			
		end
		

	end



	describe ".check_for_win" do
		context "if there's four in a row" do

			before do
				@p1_win=Game.new
				@p1_win.board[14][2]=@p1_win.player1
				@p1_win.board[15][2]=@p1_win.player1
				@p1_win.board[16][2]=@p1_win.player1
				@p1_win.board[17][2]=@p1_win.player1
			end
			it "returns true" do
				expect(@p1_win.check_for_win).to eql(true)
			end
		end

		context "if there's four connected in a column" do

			before do
				@p2_win=Game.new
				@p2_win.current_player=@p2_win.player2
				@p2_win.board[3][2]=@p2_win.player2
				@p2_win.board[10][2]=@p2_win.player2
				@p2_win.board[17][2]=@p2_win.player2
				@p2_win.board[24][2]=@p2_win.player2
			end

			it "returns true" do
				expect(@p2_win.check_for_win).to eql(true)
			end
		end

		context "if there's four connected in a left top to right bottom diagonal" do

			before do
				@p2_win=Game.new
				@p2_win.current_player=@p2_win.player2
				@p2_win.board[3][2]=@p2_win.player2
				@p2_win.board[11][2]=@p2_win.player2
				@p2_win.board[19][2]=@p2_win.player2
				@p2_win.board[27][2]=@p2_win.player2
			end


			it "returns true" do
				expect(@p2_win.check_for_win).to eql(true)
			end
		end

		context "four connected, but the diagonal wraps around the board" do


			before do
				@p2_win=Game.new
				@p2_win.current_player=@p2_win.player2
				@p2_win.board[11][2]=@p2_win.player2
				@p2_win.board[19][2]=@p2_win.player2
				@p2_win.board[27][2]=@p2_win.player2
				@p2_win.board[35][2]=@p2_win.player2
			end


			it "returns false" do
				expect(@p2_win.check_for_win).to eql(false)
			end

		end

		context "if there's four connected in a left bottom to right top diagonal" do

			before do
				@p2_win=Game.new
				@p2_win.current_player=@p2_win.player2
				@p2_win.board[3][2]=@p2_win.player2
				@p2_win.board[9][2]=@p2_win.player2
				@p2_win.board[15][2]=@p2_win.player2
				@p2_win.board[21][2]=@p2_win.player2
			end


			it "returns true" do
				expect(@p2_win.check_for_win).to eql(true)
			end
		end
	end

	describe ".check_for_draw" do
		context "if there's no empty squares" do
			before do
				@draw_game=Game.new
				49.times do |i|
					@draw_game.board[i][2]="placeholder"
				end
			end
			it "returns true" do
				expect(@draw_game.check_for_draw).to eql(true)
			end
		end

		context "if there's still open squares" do
			it "returns false" do
				@draw_game=Game.new
				expect(@draw_game.check_for_draw).to eql(false)
			end
		end
	end


	describe ".place_piece" do


		context "if a number other than 1-7 tried" do
			it "returns false" do
				expect(@new_game.place_piece(8)).to eql(false)
			end
		end
		context "if there's an empty column" do
			it "places a piece at the bottom of the column and returns true" do
				expect(@new_game.place_piece(1)).to eql(true)
			end
		end

		context "if there are pieces already in the column" do
			it "places a piece on top of the others and returns true" do
				@new_game.board[1][2]=@new_game.player2
				expect(@new_game.place_piece(2)).to eql(true)
			end
		end

		context "if the column is full" do
			it  "there is no change and returns false" do
				@new_game.board[1][2]=@new_game.player2
				@new_game.board[8][2]=@new_game.player2
				@new_game.board[15][2]=@new_game.player2
				@new_game.board[22][2]=@new_game.player2
				@new_game.board[29][2]=@new_game.player2
				@new_game.board[36][2]=@new_game.player2
				expect(@new_game.place_piece(2)).to eql(false)
			end
		end



		it "places the piece of the correct player" do

			@new_game=Game.new
			@new_game.current_player=@new_game.player2
			@new_game.place_piece(7)
			expect(@new_game.board[41][2]).to eql(@new_game.current_player)
			expect(@new_game.board[41][2]).to eql(@new_game.player2)

		end
	end

	
end