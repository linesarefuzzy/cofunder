FactoryGirl.define do
  factory :project_event do
    date { Faker::Date.between(Date.civil(2004, 01, 01), Date.today) }
    details { Faker::Lorem.paragraph }
    modified_date { Faker::Date.between(date, Date.today) }
    member_id { rand(1..50000) }
    project_id { create(:basic_project).id }
    project_table 'BasicProjects'
    summary { Faker::Lorem.sentence }
    type "Paso" # Agenda also possible

    trait :completed do
      completed { Faker::Date.between(date, Date.today) }
    end

    trait :with_logs do
      after(:create) do |event|
        create_list(
          :project_log,
          num_logs = 4,
          paso_id: event.id,
          project_id: event.project_id,
          project_table: event.project_table
        )
      end
    end
  end
end
