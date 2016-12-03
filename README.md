This exercise is from the [Odin Project](http://www.theodinproject.com/courses/ruby-programming/lessons/testing-ruby?ref=lc-pb)

I created a game of connect four that is played from the command line. The game is played on a 7x6 grid. Player's place a piece in one of the columns and the piece drops to the bottom. Whoever gets four in a row first wins. The game can also end in a draw.

I created this project by using Test Driven Development. I developed tests for methods that did not yet exist and then created methods that fit the parameters of the test.

I tested for:

a correctly initialized game that has a blank array for the grid and two players
correctly determining the winner, based on having four pieces in a row, four in a column, or four diagonally
correctly determining a draw
placing a piece in a valid column, one that exists on the grid and is not already full
