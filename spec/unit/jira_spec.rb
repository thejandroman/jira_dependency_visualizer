require 'spec_helper'

describe JiraDependencyVisualizer::Jira do # rubocop:disable Metrics/BlockLength
  context '#new' do
    it { is_expected.to be_instance_of JiraDependencyVisualizer::Jira }
  end

  let(:issue_class) do
    class_double('JIRA::Issue').as_stubbed_const
  end

  let(:issue) do
    response = double('issue')
    allow(response).to receive(:find).and_return(issue_class)
    allow(response).to receive(:jql).and_return(issue_class)
    response
  end

  let(:client) do
    response = double('client')
    allow(response).to receive(:Issue).and_return(issue)
    response
  end

  context '#get_issue' do
    it { is_expected.to respond_to(:get_issue) }
    it 'get an issue' do
      issue = subject.get_issue('issue id', client)
      expect(issue).to eq(JIRA::Issue)
    end
  end

  context '#query' do
    it { is_expected.to respond_to(:query) }
    it 'get a query' do
      query = subject.query('query', client)
      expect(query).to eq(JIRA::Issue)
    end
  end

  context '#base_url' do # rubocop:disable Metrics/BlockLength
    subject do
      JiraDependencyVisualizer::Jira.new(
        site: site,
        context_path: context_path
      )
    end
    context 'no trailing slash, no context path' do
      let(:site) { 'http://localhost' }
      let(:context_path) { '' }
      it { expect(subject.base_url).to eq('http://localhost') }
    end
    context 'no trailing slash, context path' do
      let(:site) { 'http://localhost' }
      let(:context_path) { 'jira' }
      it { expect(subject.base_url).to eq('http://localhost/jira') }
    end
    context 'trailing slash, no context path' do
      let(:site) { 'http://localhost/' }
      let(:context_path) { '' }
      it { expect(subject.base_url).to eq('http://localhost') }
    end
    context 'trailing slash, context path' do
      let(:site) { 'http://localhost/' }
      let(:context_path) { 'jira' }
      it { expect(subject.base_url).to eq('http://localhost/jira') }
    end
  end
end
