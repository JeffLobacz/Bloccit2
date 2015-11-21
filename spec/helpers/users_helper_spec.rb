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

  describe "#user_has_posts(post)" do

    let(:user) { create(:user) }
    let(:topic) { create(:topic) }
    let(:post) { create(:post) }
    let(:comment) { create(:comment, post: post, user: user) }


    it "returns true if user has authored posts" do
      user_has_posts = user.topic.post.create
      expect(user_has_posts(user).count).to eq(1)
    end

    it "returns 'nil' if the user has no posts" do
      expect(user_has_posts(user).count).to be_nil
    end

  end

end

  # describe "#user_has_comments(post)" do
  #
  #   it "returns true if user has authored comments" do
  #     user_has_comments = user.posts.comments.create
  #     expect(user_has_comments(user).count).to eq(>=1)
  #   end
  #
  #   it "returns 'nil' if the user has no posts" do
  #     expect(user_has_comments(user).count).to be_nil
  #   end
  #
  # end

# end
