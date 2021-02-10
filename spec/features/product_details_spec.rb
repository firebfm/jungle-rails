require 'rails_helper'

RSpec.feature "Visitor clicks on details button to visit product details page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They click on a product and details show" do
    # ACT
    visit root_path
    find(".btn", text: "Details", match: :first).click
    # DEBUG
    save_screenshot "prod_01.jpg"

    # VERIFY
    expect(page).to have_css 'article.product-detail'
  end
end