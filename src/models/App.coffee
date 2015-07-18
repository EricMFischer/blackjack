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

  newGame: ->
    console.log(@)
    @set 'playerHand', @.get('deck').dealPlayer()
    @set 'dealerHand', @.get('deck').dealDealer()
    @get('playerHand').on('gameover', @findWinner, @) 
    @get('playerHand').on('loss', @findWinner, @)
    @get('dealerHand').on('loss', @findWinner, @)

  findWinner: ->
    playerScore = @get('playerHand').bestScore()
    dealerScore = @get('dealerHand').bestScore()
    if playerScore>21 
      alert "Player Bust"
    else if (dealerScore>21)
      alert "You Win!!!!!"
    else if ( playerScore> dealerScore)
      alert 'You win!' 
    else alert 'You lose!'

  loser: (current)->
    alert 'gameover'
    console.log current


