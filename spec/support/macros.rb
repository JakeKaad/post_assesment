def go_home
  visit '/'
end

def create_post
  click_link "New Post"
  fill_in "Title", with: "First"
  fill_in "Content", with: "Some content."
  click_on "Create Post"
end

def create_comment
  fill_in "New Comment", with: "comment content"
  click_on "Create"
end


def register_new_user
  go_home
  click_link "Register"
  fill_in "Email", with: 'test@test.com'
  fill_in "Password", with: 'password'
  fill_in "Password confirmation", with: 'password'
  click_on "Sign up"
end
