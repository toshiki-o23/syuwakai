module SignUpSupport
  def sign_up_as(user)
    visit root_path
    click_link('新規登録')
    expect(current_path).to eq new_user_registration_path
    fill_in 'name', with: user.name
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    fill_in 'password_confirmation', with: user.password_confirmation
    find('input[type="submit"]').click
    # click_button '新規登録'
  end
end

RSpec.configure do |config|
  config.include SignUpSupport
end
