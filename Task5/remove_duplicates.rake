# frozen_string_literal: true

namespace :db do
  desc "Remove duplicate users and keep the newest"
  task remove_duplicates: :environment do
    User.find_each do |user|
      duplicates = User.where(name: user.name).order('created_at DESC')
      duplicates.shift
      duplicates.destroy_all
    end
  end
end
