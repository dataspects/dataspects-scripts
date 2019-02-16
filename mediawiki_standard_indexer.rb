require 'require_all'
require_all '../dataspects/lib'
require 'yaml'
require 'awesome_print'
$profiles = YAML.load_file('/home/lex/profiles.yml')

module Dataspects

  class MediaWikiStandardIndexer < Indexer

    def initialize(es_url:, es_user:, es_pass:, tika_url:)
      super
      # @esc.ping
    end

    def execute
      # Specify a MediaWiki as the resource silo
      label = 'localwiki0'
      mw = MediaWiki.new(
        url: $profiles[label]['url'],
        user: $profiles[label]['user'],
        password: $profiles[label]['password'],
        log_in: :must_log_in
      )
      # [[ProvidesCustomizationPossibilityFor::ResourceSilo level]]
      mw.originatedFromResourceSiloLabel = "FindAndLearn Team Site"
      mw.originatedFromResourceSiloID = "team.findandlearn.net"
      # Specify a facet of MediaWiki's resources and iterate through resources
      mw.resources_from_CATEGORY("Entity") do |re|
        # Iterate through a resource's entities
        re.entities.each do |entity|
          ap entity.esdoc
          # Store esdoc to escluster
          # @esc.index(
          #   body:,
          #   index: "my_index"
          # )
        end
      end
    end

  end

end

label = 'es.dataspects.com'
mwsi = Dataspects::MediaWikiStandardIndexer.new(
  tika_url: $development_tika_url,
  es_url: $profiles[label]['url'],
  es_user: $profiles[label]['user'],
  es_pass: $profiles[label]['password'],
).execute
