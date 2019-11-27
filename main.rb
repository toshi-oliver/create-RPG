class Brave

  def initialize(name:, hp:, offense:, defense:)
    @name = name
    @hp = hp
    @offense = offense
    @defense = defense
  end

  def name
    @name
  end

  def hp
    @hp
  end

  def offense
    @offense
  end

  def defense
    @defense
  end

end

brave = Brave.new(name:"トシー", hp:500, offense:150, defense:100)

puts <<~TEXT
NAME：#{brave.name}
HP：#{brave.hp}
OFFENSE：#{brave.offense}
DEFENSE：#{brave.defense}
TEXT