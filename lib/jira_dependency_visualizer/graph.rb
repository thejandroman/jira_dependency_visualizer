# frozen_string_literal: true

require 'graphviz'

module JiraDependencyVisualizer
  # Gets Jira issue dependencies and creates a Graphviz graph based on
  # those dependencies
  class Graph
    # @param [String] the initial issue to build the dependency graph
    #   from
    # @param [JiraDependencyVisualizer::Jira]
    # @param [Array] list of issue link types to exclude from the
    #   graph
    # @param [Hash] colors for graph; see `./config/colors.yaml`
    # @param [Graphviz]
    def initialize(start_issue_key, jira, excludes = [], colors = {}, graph = nil)
      @start_issue_key = start_issue_key
      @jira = jira
      @excludes = excludes
      @colors = colors
      @graph = graph || GraphViz.new(start_issue_key.to_sym, type: :digraph)
      @seen = []
    end

    # Retrieve a list of all tickets dependent to `@start_issue_key`
    # and add them to a Graphviz graph.
    def walk
      issue_walker(@start_issue_key)
    end

    # @param [String] filename the output filename
    # @param [String] format the graphviz output format for the graph
    def write_graph(filename = './issue_graph.svg', format = 'svg')
      @graph.output(format.to_sym => filename)
    end

    private

    def status_color(issue)
      return {} unless @colors.key?('status')
      @colors['status'][issue['fields']['status']['name']] || {}
    end

    def get_key(issue)
      issue.attrs['key']
    end

    def process_link(issue_key, link)
      return unless link.key?('outwardIssue')

      direction        = 'outward'
      linked_issue_key = link[direction + 'Issue']['key']
      link_type        = link['type'][direction]

      return linked_issue_key if @excludes.include?(link_type)

      attrs = { label: link_type }
      attrs[:color] = 'red' if link_type == 'blocks'
      node_edge_builder(issue_key, linked_issue_key, attrs)
      # node_attr_builder(linked_issue_key, status_color(link['outwardIssue']))

      linked_issue_key
    end

    def node_edge_builder(node1_key, node2_key, edge_attrs)
      @graph.add_edges(node1_key, node2_key, edge_attrs)
    end

    def node_attr_builder(issue)
      issue_key = get_key(issue)
      attrs = status_color(issue.attrs).merge(
        'URL'     => "#{@jira.base_url}/browse/#{issue_key}",
        'tooltip' => issue.attrs['fields']['summary']
      )
      node = @graph.search_node(issue_key)
      attrs.each { |k, v| node[k] = v }
    end

    def epic_walker(issue_key, children)
      issues = @jira.query("'Epic Link' = '#{issue_key}'")
      issues.each do |subtask|
        subtask_key = get_key(subtask)
        node_edge_builder(issue_key, subtask_key, color: 'orange')
        node_attr_builder(subtask)
        children.push(subtask_key)
      end
    end

    def issue_walker(issue_key)
      issue = @jira.get_issue(issue_key)
      @seen.push(issue_key)
      fields = issue.attrs['fields']
      fields.reject! { |_, v| v.nil? || v.empty? if v.is_a? Array }
      children = []

      epic_walker(issue_key, children) if fields['issuetype']['name'] == 'Epic'
      subtasks_walker(fields['subtasks'], issue_key, children) if fields.key?('subtasks')
      issuelinks_walker(fields['issuelinks'], issue_key, children) if fields.key?('issuelinks')

      (children - @seen).each { |child| issue_walker(child) }
    end

    def issuelinks_walker(issuelinks, issue_key, children)
      issuelinks.each do |other_link|
        result = process_link(issue_key, other_link)
        next if result.nil?
        children.append(result)
      end
    end

    def subtasks_walker(subtasks, issue_key, children)
      subtasks.each do |subtask|
        subtask_key = get_key(subtask)
        node_edge_builder(issue_key, subtask_key, color: 'blue', label: 'subtask')
        node_attr_builder(subtask)
        children.append(subtask_key)
      end
    end
  end
end
