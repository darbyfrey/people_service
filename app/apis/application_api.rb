class ApplicationApi < Grape::API
  format :json
  extend Napa::GrapeExtenders

  mount PeopleApi => '/people'

  add_swagger_documentation
end

