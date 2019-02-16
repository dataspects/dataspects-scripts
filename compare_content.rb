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
mw.resources_from_CATEGORY("dataspectsSystemCoreOntology")

re = OntologyRepository.new("../dataspectsSystemCoreOntology")
re.use_existing_at_URL

c = Comparer.new
c.report(mw, re)
