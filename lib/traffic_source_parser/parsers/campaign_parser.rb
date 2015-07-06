require 'traffic_source_parser/parsers/campaign_parser/campaign'
require 'uri'

module TrafficSourceParser
  module Parsers
    module CampaignParser
      extend self

      def parse(campaign_query)
        @campaign_query = campaign_query
        return Campaign.new(campaign_hash)
      end

      def campaign_hash
        parse_campaign_params.to_h
      end

      def campaign_params
        @campaign_query.scan(/(\w+=[^&]*)/).flatten
      end

      def parse_campaign_params
        campaign_params.map {|param| param.split('=') }
      end

    end
  end
end
