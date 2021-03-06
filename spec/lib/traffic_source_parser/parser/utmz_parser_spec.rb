require 'spec_helper'

describe TrafficSourceParser::Parser::UtmzParser do

  describe '.parse' do

    subject { TrafficSourceParser::Parser::UtmzParser.parse(cookie) }

    context 'when source is utmz' do

      context 'when medium is direct' do
        let(:cookie) { '153788330.1432828657.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)' }
        let(:campaign) { '(direct)' }
        let(:medium) { '(none)' }
        let(:channel) { 'Direct' }
        let(:source) { '(direct)' }

        it_behaves_like 'a traffic source campaign parser'
      end

      context 'when medium is display' do
        let(:cookie) { ' 186095035.1415927951.1.1.utmcsr=google|utmgclid=CI_WsND2-MECFezm7Aod6DsASw|utmccn=scm_beta|utmcmd=display|utmcct=Display_integra' }
        let(:campaign) { 'scm_beta' }
        let(:medium) { 'display' }
        let(:channel) { 'Display' }
        let(:source) { 'google' }

        it_behaves_like 'a traffic source campaign parser'
      end

      context 'when medium is banner' do
        let(:cookie) { '190008937.1415911938.2.2.utmcsr=botao-post|utmccn=xundacampaign|utmcmd=banner' }
        let(:campaign) { 'xundacampaign' }
        let(:medium) { 'banner' }
        let(:channel) { 'Display' }
        let(:source) { 'botao-post' }

        it_behaves_like 'a traffic source campaign parser'
      end

            context 'when medium is ppc but source is social' do
        let(:cookie) { '78301271.1443725657.1.1.utmcsr=facebook|utmccn=fb_retargeting_1|utmcmd=ppc' }
        let(:campaign) { 'fb_retargeting_1' }
        let(:medium) { 'ppc' }
        let(:channel) { 'Social' }
        let(:source) { 'Facebook' }

        it_behaves_like 'a traffic source campaign parser'
      end

      context 'when medium is from social' do

        context 'with content and from referral medium' do
          let(:cookie) { '231152653.1432828491.1.1.utmcsr=t.co|utmccn=(referral)|utmcmd=referral|utmcct=/teste' }
          let(:campaign) { '(referral)' }
          let(:medium) { 'referral' }
          let(:channel) { 'Social' }
          let(:source) { 'Twitter' }
          let(:content) { '/teste' }

          it_behaves_like 'a traffic source campaign parser with content'
        end

        context 'with content and from custom medium' do
          let(:cookie) { '1.1111111111.1.1.utmcsr=facebook|utmccn=experimentar-ferramenta|utmcmd=sponsored-post|utmctr=|utmcct=organize-seus-negocios' }
          let(:campaign) { 'experimentar-ferramenta' }
          let(:medium) { 'sponsored-post' }
          let(:channel) { 'Social' }
          let(:source) { 'Facebook' }
          let(:content) { 'organize-seus-negocios' }

          it_behaves_like 'a traffic source campaign parser with content'
        end

        context 'without content' do
          let(:cookie) { '10083233.1432828099.1.1.utmcsr=facebook.com|utmccn=20150528-ef-aprovacaoharvard|utmcmd=socialmedia-fe' }
          let(:campaign) { '20150528-ef-aprovacaoharvard' }
          let(:medium) { 'socialmedia-fe' }
          let(:channel) { 'Social' }
          let(:source) { 'Facebook' }

          it_behaves_like 'a traffic source campaign parser'
        end

      end

      context 'when value is from referral' do
        {
          cookie_value: "210677130.1432831711.1.1.utmcsr=rakuten|utmc" +
                        "cn=linkshare|utmcmd=(not set)",
          source: "rakuten",
          campaign: "linkshare",
          channel: "Referral",
          medium: "(not set)"
        }
      end

      context 'when value is from other advertising' do
        {
          cookie_value: "10083233.1432828147.6.5.utmcsr=newsletter|ut" +
                        "mccn=20150527|utmcmd=newsletter-ef|utmctr=communi" +
                        "tycolleges|utmcct=programa",
          source: "newsletter",
          campaign: "20150527",
          channel: "Other",
          medium: "newsletter-ef",
          term: "communitycolleges",
          content: "programa"
        }
      end

      context 'when value is from CPC campaign' do
        {
          cookie_value: "63514687.1432831892.1.1.utmcsr=adwords_gereb" +
                        "oletos1min5_22072014|utmgclid=CNjQrtjy5MUCFQYXHwo" +
                        "d7k0A8g|utmccn=(not set)|utmcmd=(not set)",
          source: "adwords_gereboletos1min5_22072014",
          campaign: "(not set)",
          channel: "Paid Search",
          medium: "cpc"
        }
      end

    end

  end

end
