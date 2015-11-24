require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do

  describe "#user_has_posts(user)" do

    let(:user) { create(:user) }
    let(:post) { create(:post) }

    it "returns false if the user has no posts" do
      expect(user_has_posts(user)).to eq(false)
    end

    it "returns true if user has authored posts" do
      create(:post, user: user)
      expect(user_has_posts(user)).to eq(true)
    end

  end

  describe "#user_has_comments(post)" do

    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let(:comment) { create(:comment, post: post, user: user) }

    it "returns false if the user has no comments" do
      expect(user_has_comments(user)).to eq(false)
    end

    it "returns true if user has authored comments" do
      create(:comment, post: post, user: user)
      expect(user_has_comments(user)).to eq(true)
    end

  end

  describe "#user_has_favorites(post)" do

    let(:user) { create(:user) }
    let(:post) { create(:post) }

    it "returns false if the user has no favorites" do
      expect(user_has_favorites(user)).to eq(false)
    end

    it "returns true if user has favorites" do
      user.favorites.where(post: post).create
      expect(user_has_favorites(user)).to eq(true)
    end

  end

end
