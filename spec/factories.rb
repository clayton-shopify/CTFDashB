# frozen_string_literal: true

FactoryBot.define do
  factory :hint do
    challenge { nil }
    hint_text { "MyText" }
    penalty { 1.5 }
  end
  factory :user do
    sequence(:name) { |n| "Hacker name #{n}" }
    sequence(:email) { |n| "hacker-#{n}@ctfdashb.com" }
    sequence(:username) { |n| "hacker-username-#{n}" }
    password { 'sher123' }
    password_confirmation { 'sher123' }
    team
  end

  factory :team do
    sequence(:name) { |n| "team-#{n}" }
  end

  factory :session do
    user
    ip_address { '192.168.1.1' }
    browser { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) '\
      'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36' }
  end

  factory :category do
    sequence(:name) { |n| "category-#{n}" }
  end

  factory :challenge do
    title { 'SQLi baby' }
    category
    description { 'you need the flag' }
    link { 'sqli.baby' }
    flag { 'flag{5QL1_15_AWES0ME}' }
    points { 100 }
    max_tries { 100 }
    active { true }
  end

  factory :flag_regex, class: CtfSetting do
    key { 'flag_regex' }
    value { 'flag{[A-Za-z0-9_]+}' }
  end

  factory :team_size, class: CtfSetting do
    key { 'team_size' }
    value { 4 }
  end

  factory :submission do
    challenge
    category { challenge.category }
    flag { 'flag{invalid}' }
    user
    team
    submission_hash { 'submission_hash' }
  end
end
