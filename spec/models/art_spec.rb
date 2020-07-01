require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Art, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:photo) }
  end

  describe "associations" do
    it { should belong_to(:artist)}
  end

  describe "class methods" do
  end

end
