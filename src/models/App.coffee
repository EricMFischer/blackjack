# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'playerPurse', 1000
    @set 'currentBet', 0
    #listener for hand stand method 
    @get('playerHand').on('gameover', @findWinner, @) 
    @get('playerHand').on('loss', @findWinner, @)
    @get('dealerHand').on('loss', @findWinner, @)

  newGame: ->
    console.log(@)
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @get('playerHand').on('gameover', @findWinner, @) 
    @get('playerHand').on('loss', @findWinner, @)
    @get('dealerHand').on('loss', @findWinner, @)

  increaseBet: ->
    @set 'currentBet', @get('currentBet') + 10
    @set 'playerPurse', @get('playerPurse') - 10




  findWinner: ->
    playerScore = @get('playerHand').bestScore()
    dealerScore = @get('dealerHand').bestScore()
    if playerScore>21 
      alert "Player Bust"
    else if (dealerScore>21)
      alert "You Win!!!!!"
      @set 'playerPurse', (@get('playerPurse') + 2*@get('currentBet'))
    else if ( playerScore> dealerScore)
      alert 'You win!' 
      @set 'playerPurse', (@get('playerPurse') + 2*@get('currentBet'))
    else alert 'You lose!'

    @set 'currentBet', 0

