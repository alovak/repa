Factory.define :user do |u|
  u.sequence(:name)  {|n| "John Doe #{n}" }
  u.sequence(:email) {|n| "person#{n}@example.com" }
  u.password 'password'
end

Factory.define :ticket do |t|
  t.sequence(:title) {|n| "Title #{n}"}
  t.sequence(:description) {|n| "Description #{n}"}
  t.association :assignee, :factory => :user
  t.association :owner,    :factory => :user
end

# Factory.define :assignee, :parent => :user do |u|
# end
