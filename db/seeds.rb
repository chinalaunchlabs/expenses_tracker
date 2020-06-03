categories = [
  { name: "Food & Drinks", icon: "/images/ic_food_drinks.png" },
  { name: "Groceries", icon: "/images/ic_groceries.png" },
  { name: "Clothes", icon: "/images/ic_clothes.png" },
  { name: "Electronics", icon: "/images/ic_electronics.png" },
  { name: "Healthcare", icon: "/images/ic_healthcare.png" },
  { name: "Gifts", icon: "/images/ic_gifts.png" },
  { name: "Transportation", icon: "/images/ic_transportation.png" },
  { name: "Education", icon: "/images/ic_education.png" },
  { name: "Entertainment", icon: "/images/ic_entertainment.png" },
  { name: "Utilities", icon: "/images/ic_utilities.png" },
  { name: "Rent", icon: "/images/ic_rent.png" },
  { name: "Household Supplies", icon: "/images/ic_household.png" },
  { name: "Investments", icon: "/images/ic_investments.png" },
  { name: "Other", icon: "/images/ic_other.png" }
]

if Category.count == 0
  categories.each do |cat|
    Category.create(name: cat[:name], icon: cat[:icon])
  end
end