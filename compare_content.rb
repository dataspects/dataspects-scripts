require 'require_all'
require_all '../dataspects/lib'
require 'yaml'
profiles = YAML.load_file('/home/lex/profiles.yml')

label = 'cookbook.findandlearn.net'
mw = Dataspects::MediaWiki.new(
  url: profiles[label]['url'],
  user: profiles[label]['user'],
  password: profiles[label]['password'],
  log_in: :must_log_in
)

ontology = "dataspectsSystemCoreOntology"
re = Dataspects::OntologyRepository.new("../#{ontology}")
re.use_existing_at_URL

mw.resources_from_CATEGORY(ontology)
c = Dataspects::Comparer.new
c.report(re, mw)
