class PeopleApi < Grape::API
  desc 'Get a list of people'
  params do
    optional :ids, type: String, desc: 'comma separated person ids'
  end
  get do
    people = Person.filter(declared(params, include_missing: false))
    represent people, with: PersonRepresenter
  end

  desc 'Create a person'
  params do
    optional :name, type: String, desc: 'The Name of the person'
    optional :job_title, type: String, desc: 'The Job Title of the person'
    optional :email, type: String, desc: 'The Email Address of the person'
  end
  post do
    person = Person.create(declared(params, include_missing: false))
    error!(present_error(:record_invalid, person.errors.full_messages)) unless person.errors.empty?
    represent person, with: PersonRepresenter
  end

  params do
    requires :id, desc: 'ID of the person'
  end
  route_param :id do
    desc 'Get an person'
    get do
      person = Person.find(params[:id])
      represent person, with: PersonRepresenter
    end

    desc 'Update a person'
    params do
      optional :name, type: String, desc: 'The Name of the person'
      optional :job_title, type: String, desc: 'The Job Title of the person'
      optional :email, type: String, desc: 'The Email Address of the person'
    end
    put do
      # fetch person record and update attributes.  exceptions caught in app.rb
      person = Person.find(params[:id])
      person.update_attributes!(declared(params, include_missing: false))
      represent person, with: PersonRepresenter
    end
  end
end
