require './brave.rb'
require './monster.rb'


brave = Brave.new(name: "トシー", hp: 500, offense: 250, defense: 100)
monster = Monster.new(name: "ズライム", hp: 250, offense: 200, defense: 100)

loop do
  brave.attack(monster)
  break if monster.hp <= 0

  monster.attack(brave)
  break if brave.hp <= 0
end

battle_result = brave.hp > 0

if battle_result
  exp = (monster.offense + monster.defense) * 2
  gold = (monster.offense + monster.defense) * 3
  puts "#{brave.name}はたたかいに勝った"
  puts "#{exp}の経験値と#{gold}ゴールドを獲得した"
else

  puts "#{brave.name}はたたかいに負けた"
  puts "目の前が真っ暗になった"
end