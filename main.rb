class Brave
  attr_reader :name, :hp, :offense, :defense
  attr_writer :hp

  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end

end

brave = Brave.new(name:"トシー", hp: 500, offense: 150, defense: 100)

puts <<~TEXT
NAME：#{brave.name}
HP：#{brave.hp}
OFFENSE：#{brave.offense}
DEFENSE：#{brave.defense}
TEXT

brave.hp -= 30