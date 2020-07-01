require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Artist, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "validations" do
    it { should validate_presence_of(:age) }
    it { should validate_presence_of(:bio) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:artist_name) }
    it { should validate_presence_of(:photo) }
  end

  describe "associations" do
    it { should have_many(:arts)}
    # it { should have_many(:orders)}
    it { should belong_to(:user)}
  end

  describe "class methods" do
  end

end
