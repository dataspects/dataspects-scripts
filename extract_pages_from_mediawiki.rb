require 'require_all'
require_all '../dataspects/lib'
require 'yaml'
profiles = YAML.load_file('/home/lex/profiles.yml')

label = 'localwiki0'
mw = Dataspects::MediaWiki.new(
  url: profiles[label]['url'],
  user: profiles[label]['user'],
  password: profiles[label]['password'],
  log_in: :must_log_in
)

re = Dataspects::OntologyRepository.new("/home/lex/localwiki0_entities")
re.create_new_at_URL
mw.resources_from_CATEGORY("Entity") do |resource|
  re.store_RESOURCE(resource)
end
