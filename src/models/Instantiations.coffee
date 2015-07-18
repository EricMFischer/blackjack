 Instantiations

 # Main coffee
 new AppView(model: new App()).$el.appendTo 'body'


 # App model
 class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()


# Deck collection
initialize: ->
  @add _([0...52]).shuffle().map (card) ->
    new Card
      rank: card % 13
      suit: Math.floor(card / 13)

dealPlayer: -> new Hand [@pop(), @pop()], @

dealDealer: -> new Hand [@pop().flip(), @pop()], @, true


# App View
render: ->
  @$el.children().detach()
  @$el.html @template()
  @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
  @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el


# Hand View
render: ->
  @$el.children().detach()
  @$el.html @template @collection
  @$el.append @collection.map (card) ->
    new CardView(model: card).$el
  @$('.score').text @collection.scores()[0]