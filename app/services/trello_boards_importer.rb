class TrelloBoardsImporter

  def self.init_for_user(user)
    config = user.user_configuration

    public_key = config.developer_public_key
    token = config.member_token

    new(public_key, token)
  end

  def initialize(public_key, token)
    @public_key = public_key
    @token = token
  end

  def boards
    me = trello_client.find('member', 'me')
    me.boards
  end

  def import(trello_board_id)
    trello_board = trello_client.find('board', trello_board_id)

    board = Board.new(name: trello_board.name, visibility: 'public')

    trello_board.lists.each do |trello_list|
      list = board.lists.build(name: trello_list.name)

      import_cards(trello_list, list)
    end

    board
  end

  private

  def import_cards(trello_list, list)
    trello_list.cards.each do |trello_card|
      list.cards.build(title: trello_card.name)
    end
  end

  def trello_client
    @trello_client ||= Trello::Client.new(
      developer_public_key: @public_key,
      member_token: @token
    )
  end
end
