module SignUpSupport
  def sign_up_as(user)
    visit root_path
    click_link('新規登録')
    expect(current_path).to eq new_user_registration_path
    fill_in 'user_name', with: 'としき'
    fill_in 'user_email', with: 'toshiki@gmail.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    find('input[type="submit"]').click
  end
end

RSpec.configure do |config|
  config.include SignUpSupport
end
