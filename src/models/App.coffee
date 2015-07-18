# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    #listener for hand stand method 
    @get('playerHand').on('gameover', @findWinner, @) 
    @get('playerHand').on('loss', @findWinner, @)
    @get('dealerHand').on('loss', @findWinner, @)


  findWinner: ->
    playerScore = @get('playerHand').bestScore()
    dealerScore = @get('dealerHand').bestScore()
    if playerScore>21 then alert "Player Bust"
    if dealerScore>21 then alert "You Win!!!!!"
    alert if ( playerScore> dealerScore) then 'You win!' else 'You lose!'
      # call bestScore on dealer and on player
      #determine the winner
      #display the winner

  loser: (current)->
    alert 'gameover'
    console.log current


