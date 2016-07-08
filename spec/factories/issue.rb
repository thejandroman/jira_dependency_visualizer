# frozen_string_literal: true
FactoryGirl.define do
  factory :subtask_issue, class: OpenStruct do
    attrs do
      {
        'key' => 'test3',
        'fields' => {
          'issuetype' => {
            'name' => 'notEpic'
          },
          'status' => {
            'name' => 'To Do'
          },
          'subtasks' => [build(:generic_issue)]
        }
      }
    end
  end

  factory :generic_issue, class: OpenStruct do
    attrs do
      {
        'key' => 'test5',
        'fields' => {
          'status' => {
            'name' => 'Blocked'
          }
        }
      }
    end
  end

  factory :issuelinks_generic_issue, class: Hash do
    outwardIssue do
      { 'key' => 'test3',
        'fields' => {
          'status' => {
            'name' => 'Done'
          }
        } }
    end

    type do
      { 'outward' => 'blocks' }
    end

    initialize_with { attributes.stringify_keys }
  end

  factory :issuelinks_issue, class: OpenStruct do
    attrs do
      {
        'key' => 'test4',
        'fields' => {
          'issuetype' => {
            'name' => 'notEpic'
          },
          'status' => {
            'name' => 'To Do'
          },
          'issuelinks' => [build(:issuelinks_generic_issue)]
        }
      }
    end
  end

  factory :epic_issue, class: OpenStruct do
    attrs do
      {
        'key' => 'test',
        'fields' => {
          'issuetype' => {
            'name' => 'Epic'
          },
          'status' => {
            'name' => 'Planning'
          }
        }
      }
    end
  end
end
