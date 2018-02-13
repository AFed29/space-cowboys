require('pry-byebug')
require_relative('models/bounty.rb')

bounty1 = Bounty.new (
  {
    'name' => 'Mal Reynolds',
    'danger_level' => 'ermagerdyerderd',
    'last_known_location' => 'Beaumonde',
    'cashed_in' => false
  }
)

bounty2 = Bounty.new (
  {
    'name' => 'Greedo',
    'danger_level' => 'low',
    'last_known_location' => 'Tatooine',
    'cashed_in' => true
  }
)

binding.pry

nil
