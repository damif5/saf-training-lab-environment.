describe yaml('/workspaces/saf-training-lab-environment./resources/docker-compose.yml') do
  its(['services', 'workstation', 'image']) { should eq 'learnchef/inspec_workstation'}
  its(['services', 'workstation', 'volumes']) { should cmp '.:/root' }
end
