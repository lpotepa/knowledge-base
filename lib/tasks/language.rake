# frozen_string_literal: true

namespace :language do
  desc 'TODO'
  task add: :environment do
    ARGV.each { |a| task a.to_sym do; end }
    Language.create!(name: ARGV[1], iso: ARGV[2])
  end
end
