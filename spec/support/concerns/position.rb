require 'rails_helper'

shared_examples_for 'position' do
  let(:model) { described_class }

  let(:subject1) { FactoryGirl.create(model.to_s.underscore.to_sym, position: 2) }
  let(:subject2) { FactoryGirl.create(model.to_s.underscore.to_sym, position: 1) }
  let(:subject3) { FactoryGirl.create(model.to_s.underscore.to_sym, position: 3) }

  it 'should have scope' do
    expect(model.by_position).to eq [subject2, subject1, subject3]
  end

  it 'should have update_positions method' do
    model.update_positions([subject1.id, subject2.id, subject3.id])
    expect(subject1.reload.position).to eq 0
    expect(subject2.reload.position).to eq 1
    expect(subject3.reload.position).to eq 2
  end
end