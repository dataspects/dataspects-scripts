require 'require_all'
require_all '../dataspects/lib'
require 'yaml'
profiles = YAML.load_file('/home/lex/profiles.yml')

module Dataspects

  class MediaWikiStandardIndexer < Indexer

    def initialize(es_url:, es_user:, es_pass:, tika_url:)
      super
      @esc.ping
    end

    def execute
      # Specify a MediaWiki as the resource silo
      label = 'cookbook.findandlearn.net'
      mw = Dataspects::MediaWiki.new(
        url: profiles[label]['url'],
        user: profiles[label]['user'],
        password: profiles[label]['password'],
        log_in: :must_log_in
      )
      # [[ProvidesCustomizationPossibilityFor::ResourceSilo level]]
      mediawiki.originatedFromResourceSiloLabel = "FindAndLearn Cookbook"
      mediawiki.originatedFromResourceSiloID = "cookbook.findandlearn.net"
      # Specify a facet of MediaWiki's resources and iterate through resources
      mediawiki.resources_from_CATEGORY("Entity") do |resource|
        # Iterate through a resource's entities
        resource.entities.each do |entity|
          # Store esdoc to escluster
          @esc.index(
            body: {
              # Resource
              "HasResourceName": entity.resource.hasResourceName,
              "HasResourceURL": entity.resource.hasResourceName,
              "HasResourceType": entity.resource.hasResourceType,
              # Entity
              "HasEntityClass": entity.hasEntityClass,
              "HasEntityName": entity.hasEntityName,
              "HasEntityType": entity.hasEntityType,
              "HasEntityURL": entity.hasEntityURL,
              "HasEntityTitle": entity.hasEntityTitle,
              "HasEntityBlurb": entity.hasEntityBlurb,
              "HasEntityContent": entity.hasEntityContent
            },
            index: "my_index"
          )
        end
      end
    end

  end

end

label = 'es.dataspects.com'
mwsi = Dataspects::MediaWikiStandardIndexer.new(
  tika_url: $development_tika_url,
  url: profiles[label]['url'],
  user: profiles[label]['user'],
  password: profiles[label]['password'],
).execute
