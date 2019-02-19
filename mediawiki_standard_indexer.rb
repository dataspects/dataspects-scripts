require 'require_all'
require_all '../dataspects/lib'
require 'yaml'
require 'awesome_print'
$profiles = YAML.load_file('/home/lex/profiles.yml')

module Dataspects

  class MediaWikiStandardIndexer < Indexer

    def initialize(es_url:, tika_url:)
      super
      # Reset index for development
      index = 'dataspectspublic'
      @esc.client.indices.delete(index: index)
      @esc.client.indices.create(index: index)
      @esc.client.indices.close(index: index)
      @esc.client.indices.put_settings(
        index: index,
        body: JSON.parse(File.read(
          '../dataspects/lib/dataspects/indexing/standard_index_settings.json'))
      )
      @esc.client.indices.put_mapping(
        index: index,
        type: 'doc',
        body: JSON.parse(File.read(
          '../dataspects/lib/dataspects/indexing/standard_index_mapping.json'))
      )
      @esc.client.indices.open(index: index)
    end

    def execute
      # Specify a MediaWiki as the resource silo
      label = 'cookbook.findandlearn.net'
      mw = MediaWiki.new(
        url: $profiles[label]['url'],
        user: $profiles[label]['user'],
        password: $profiles[label]['password'],
        log_in: :must_log_in
      )
      # [[ProvidesCustomizationPossibilityFor::ResourceSilo level]]
      mw.originatedFromResourceSiloLabel = "FindAndLearn::Cookbook"
      mw.originatedFromResourceSiloID = "cookbook.findandlearn.net"
      # Specify a facet of MediaWiki's resources and iterate through resources
      mw.resources_from_CATEGORY("Entity") do |re|
        # Iterate through a resource's entities
        re.entities.each do |entity|
          # Store esdoc to escluster
          @esc.index(
            body: entity.esdoc,
            index: "dataspectspublic"
          )
          $logger.info("#{entity.hasEntityURL} indexed...")
        end
      end
    end

  end

end

label = 'es.dataspects.com'
mwsi = Dataspects::MediaWikiStandardIndexer.new(
  tika_url: "http://10.100.0.123:9998",
  es_url: $profiles[label]['url']
).execute
