require 'jira-ruby'

module JiraDependencyVisualizer
  # Creates a Jira client and exposes functions to get Jira issues
  class Jira
    # @param [Hash] opts the options to create a Jira client
    # @option opts [String] :context_path The Jira application's
    #   context path
    # @option opts [String] :password The Jira user's password
    # @option opts [String] :proxy_address The proxy address
    # @option opts [Integer] :proxy_port The proxy port
    # @option opts [Integer] :read_timeout Number of seconds to wait
    #   for data to be read
    # @option opts [String] :rest_base_path The Jira rest API base
    #   path
    # @option opts [String] :site URL for Jira
    # @option opts [Boolean] :use_ssl Whether to use SSL
    # @option opts [String] :username The Jira user's username
    def initialize(opts = {})
      @options = opts
      client
    end

    # @param [String] issue the Jira issue ID
    # @param [JIRA::Client] client a Jira client instance
    # @return [JIRA::Issue] the matched Jira issue object
    def get_issue(issue, client = @client)
      client.Issue.find(issue)
    end

    # @param [String] query a Jira JQL query string
    # @param [JIRA::Client] client a Jira client instance
    # @return [Array[JIRA::Issue]] list of matching Jira issue objects
    def query(query, client = @client)
      client.Issue.jql(query)
    end

    # @return [String] the base Jira URL without a trailing slash
    def base_url
      site         = @options[:site].dup
      context_path = @options[:context_path].dup

      site.chop! if site.ends_with?('/')
      context_path.chop! if context_path.ends_with?('/')

      URI.join(site, context_path).to_s
    end

    private

    def client
      @client ||= JIRA::Client.new(@options)
    end
  end
end
