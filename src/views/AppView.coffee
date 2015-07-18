class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="new-game-button">New Game</button> <button class="bet-button">Bet</button>
    <div class="betting-bar"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>

  '

  events:

    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> 
      @model.get('playerHand').stand()
      @model.newGame()
      @render()
    'click .new-game-button': -> 
      @model.newGame()
      @render()
    'click .bet-button': -> 
      @model.increaseBet()
      @render()


  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.betting-bar').html('<span>Current Bet = ' + @model.get('currentBet') + '  Purse: '   + @model.get('playerPurse') + '</span>')
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

