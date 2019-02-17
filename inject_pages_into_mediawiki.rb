require 'require_all'
require_all '../dataspects/lib'
require 'yaml'
profiles = YAML.load_file('/home/lex/profiles.yml')

label = 'teamfalnet'
mw = Dataspects::MediaWiki.new(
  url: profiles[label]['url'],
  user: profiles[label]['user'],
  password: profiles[label]['password'],
  log_in: :must_log_in
)

re = Dataspects::OntologyRepository.new("../dataspectsSystemCoreOntology")
re.use_existing_at_URL
re.resources.each do |resource|
  mw.store_RESOURCE(resource, "Injection job 190215")
end

re = Dataspects::OntologyRepository.new("../ConferenceManagementOntology")
re.use_existing_at_URL
re.resources.each do |resource|
  mw.store_RESOURCE(resource, "Injection job 190215")
end

re = Dataspects::OntologyRepository.new("../MeetingMinutesOntology")
re.use_existing_at_URL
re.resources.each do |resource|
  mw.store_RESOURCE(resource, "Injection job 190215")
end

re = Dataspects::OntologyRepository.new("../TaskManagementOntology")
re.use_existing_at_URL
re.resources.each do |resource|
  mw.store_RESOURCE(resource, "Injection job 190215")
end

re = Dataspects::OntologyRepository.new("../teamfalnet_entities")
re.use_existing_at_URL
re.resources.each do |resource|
  mw.store_RESOURCE(resource, "Injection job 190215")
end
