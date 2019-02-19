require 'require_all'
require_all '../dataspects/lib'
require 'yaml'
profiles = YAML.load_file('/home/lex/profiles.yml')

label = 'team.findandlearn.net'
mw = Dataspects::MediaWiki.new(
  url: profiles[label]['url'],
  user: profiles[label]['user'],
  password: profiles[label]['password'],
  log_in: :must_log_in
)

# re = Dataspects::OntologyRepository.new("../dataspectsSystemCoreOntology")
# re.use_existing_at_URL
# re.resources.each do |resource|
#   sleep 1
#   mw.store_RESOURCE(resource, "Injection job 190218")
# end

# re = Dataspects::OntologyRepository.new("../ConferenceManagementOntology")
# re.use_existing_at_URL
# re.resources.each do |resource|
#   mw.store_RESOURCE(resource, "Injection job 190215")
# end

# re = Dataspects::OntologyRepository.new("../MeetingMinutesOntology")
# re.use_existing_at_URL
# re.resources.each do |resource|
#   mw.store_RESOURCE(resource, "Injection job 190215")
# end

# re = Dataspects::OntologyRepository.new("../TaskManagementOntology")
# re.use_existing_at_URL
# re.resources.each do |resource|
#   mw.store_RESOURCE(resource, "Injection job 190215")
# end
#
# re = Dataspects::OntologyRepository.new("../IssueManagementOntology")
# re.use_existing_at_URL
# re.resources.each do |resource|
#   mw.store_RESOURCE(resource, "Injection job 190215")
# end

# re = Dataspects::OntologyRepository.new("../teamfalnet_entities")
# re.use_existing_at_URL
# re.resources.each do |resource|
#   mw.store_RESOURCE(resource, "Injection job 190215")
# end
