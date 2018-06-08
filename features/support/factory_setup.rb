puts "Setting up Factory matchers..."

# Use factories for data.
#
World(FactoryBot::Syntax::Methods)

# Produce a set of matchers for everything defined using FactoryBoy.
#
FactoryBot.factories.each do |factory|
  factory_name = factory.name.to_s.humanize.downcase
  factory_matcher = [factory_name, factory_name.pluralize].join('|')
  Given(/^there (?:is|are) (an?|-?\d+) (?:#{factory_matcher})$/) do |n|
    FactoryBot.create_list factory_name, n
  end
end
