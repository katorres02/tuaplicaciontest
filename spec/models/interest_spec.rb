require 'rails_helper'

RSpec.describe Interest, type: :model do
  it { should validate_presence_of :name }
end
