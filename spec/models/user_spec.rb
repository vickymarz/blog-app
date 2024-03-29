require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Faith', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
             posts_counter: 2)
  end

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'post counter should not be less than 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'post counter should be an integer' do
    subject.posts_counter = 1.2
    expect(subject).to_not be_valid
  end
end
