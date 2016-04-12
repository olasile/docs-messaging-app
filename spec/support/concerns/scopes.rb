require 'rails_helper'

shared_examples_for 'scopes' do
  let(:model) { described_class }

  it 'should set default role' do
    subject1 = FactoryGirl.create(model.to_s.underscore.to_sym, created_at: Date.today + 1.day)
    subject2 = FactoryGirl.create(model.to_s.underscore.to_sym, created_at: Date.today)
    subject3 = FactoryGirl.create(model.to_s.underscore.to_sym, created_at: Date.today - 1.day)
    
    expect(model.by_created_at).to eq [subject1, subject2, subject3]
  end
end

