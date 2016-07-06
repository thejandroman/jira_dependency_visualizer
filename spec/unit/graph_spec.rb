require 'spec_helper'

describe JiraDependencyVisualizer::Graph do
  subject { JiraDependencyVisualizer::Graph.new('issue id', jira, [], colors, graph) }

  let(:epic_issue) { build(:epic_issue) }
  let(:issues) { build_pair(:subtask_issue) }

  let(:jira) do
    response = double('jira')
    allow(response).to receive(:get_issue).and_return(epic_issue)
    allow(response).to receive(:query).and_return(issues)
    allow(response).to receive(:base_url).and_return('http://localhost')
    response
  end

  let(:node) { build(:node) }

  let(:graph) do
    response = double('graph')
    allow(response).to receive(:add_edges).and_return(true)
    allow(response).to receive(:search_node).and_return(node)
    allow(response).to receive(:output).and_return(nil)
    response
  end

  let(:colors) do
    {
      'status' => {
        'Incoming' => {
          'fillcolor' => 'purple',
          'style'     => 'filled'
        },
        'To Do' => {
          'fillcolor' => 'purple',
          'style'     => 'filled',
          'fontcolor' => 'white'
        }
      }
    }
  end

  context '#new' do
    it { is_expected.to be_instance_of JiraDependencyVisualizer::Graph }
  end

  context '#walk subtasks' do
    let(:issues) { build_pair(:subtask_issue) }

    let(:jira) do
      response = double('jira')
      allow(response).to receive(:get_issue).and_return(epic_issue, issues[0])
      allow(response).to receive(:query).and_return(issues)
      allow(response).to receive(:base_url).and_return('http://localhost')
      response
    end

    it { expect(subject.walk).to eq(%w(test3 test3)) }
  end

  context '#walk issuelinks' do
    let(:issues) { build_pair(:issuelinks_issue) }

    let(:jira) do
      response = double('jira')
      allow(response).to receive(:get_issue).and_return(epic_issue, issues[0])
      allow(response).to receive(:query).and_return(issues)
      allow(response).to receive(:base_url).and_return('http://localhost')
      response
    end

    it { expect(subject.walk).to eq(%w(test4 test4)) }
  end

  context '#write_graph' do
    it { is_expected.to respond_to(:write_graph) }
    it 'write a graph' do
      written_graph = subject.write_graph
      expect(written_graph).to eq(nil)
    end
  end
end
