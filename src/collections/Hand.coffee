class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    card = @deck.pop()
    @add(card)
    currentScore = @scores()
    if currentScore[0] > 21 
      @trigger 'loss' , @
    card

  stand: -> 
    #Trigger an event on AppView that calls bestScore on both hands and determines the winner
    @trigger 'gameover' 
    

  bestScore: -> 
    if @isDealer && !@models[0].attributes.revealed
      @models[0].flip();

    currentScore = @scores()
    if @isDealer
      if currentScore[0] >= 17 then return currentScore[0]
      if currentScore[1] >= 18 then return currentScore[1]
      @hit()
      @bestScore()
    else 
      return if (currentScore[1] < 21) then  currentScore[1] else  currentScore[0]



  #return the maximum score possible with current cards
  #If @isDealer then keep hitting till max score >17
  #if dealer loses display "Dealer loses"
  #return score


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


