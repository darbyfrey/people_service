class PersonRepresenter < Napa::Representer
  property :id, type: String
  property :name
  property :job_title
  property :email
end
