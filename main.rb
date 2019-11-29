require './character'

class Brave < Character
  SPECIAL_ATTACK_CONSTANT = 1.5

  def attack(monster)
    puts "#{@name}の攻撃"

    attack_type = decision_attack_type
    damage = calculate_damage(target: monster, attack_type: attack_type)
    cause_damage(target: monster, damage: damage)

    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  private

    def decision_attack_type
      attack_num = rand(4)

      if attack_num == 0
        puts "必殺攻撃"
        "special_attack"
      else
        puts "通常攻撃"
        "nomal_attack"
      end
    end

    def calculate_damage(**params)
      target = params[:target]
      attack_type = params[:attack_type]

      if attack_type == "special_attack"
        calculate_special_attack - target.defense
      else
        @offense - target.defense
      end
    end

    def cause_damage(**params)
      target = params[:target]
      damage = params[:damage]

      target.hp -= damage
      target.hp = 0 if target.hp < 0

      puts "#{target.name}は#{damage}のダメージを受けた"
    end

    def calculate_special_attack
      @offense * SPECIAL_ATTACK_CONSTANT
    end

end

class Monster < Character

  POWER_UP_RATE = 1.5
  CALC_HALF_HP = 0.5

  def initialize(**params)
    super(
      name: params[:name],
      hp: params[:hp],
      offense: params[:offense],
      defense: params[:defense]
    )

    @transform_flag = false
    @trigger_of_transform = params[:hp] * CALC_HALF_HP
  end

  def attack(brave)
    if @hp <= @trigger_of_transform && @transform_flag == false
      @transform_flag = true
      transform
    end

    puts "#{@name}の攻撃"

    damage = calculate_damage(brave)
    cause_damage(damage: damage, target: brave)

    puts "#{brave.name}の残りHPは#{brave.hp}だ"
  end

  private

    def calculate_damage(target)
      @offense -  target.defense
    end

    def cause_damage(**params)
      damage = params[:damage]
      target = params[:target]

      target.hp -= damage

      puts "#{target.name}は#{damage}のダメージを受けた"
    end

    def transform
      transform_name = "ドラゴン"

      puts <<~EOS
      #{@name}は怒っている
      #{@name}はドラゴンに変身した
      EOS

      @name = transform_name
      @offense *= POWER_UP_RATE
    end

  def cause_damage(**params)
    damage = params[:damage]
    target = params[:target]

    target.hp -= damage

    target.hp = 0 if target.hp < 0

    puts "#{target.name}は#{damage}のダメージを受けた"
  end

end

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