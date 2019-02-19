require 'require_all'
require_all '../dataspects/lib'
require 'yaml'
profiles = YAML.load_file('/home/lex/profiles.yml')

label = 'team.findandlearn.net'

ontology = "ConferenceManagementOntology"

mw = Dataspects::MediaWiki.new(
  url: profiles[label]['url'],
  user: profiles[label]['user'],
  password: profiles[label]['password'],
  log_in: :must_log_in
)
mw.resources_from_CATEGORY(ontology)

re = Dataspects::OntologyRepository.new("../#{ontology}")
re.use_existing_at_URL

c = Dataspects::Comparer.new
c.report(mw, re)
