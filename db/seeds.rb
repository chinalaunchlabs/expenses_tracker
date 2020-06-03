categories = [
  "Food & Drinks",
  "Groceries",
  "Clothes",
  "Electronics",
  "Medicine",
  "Pets",
  "Kids",
  "Gifts",
  "Transportation",
  "Books",
  "Education",
  "Hobbies",
  "Music",
  "Wellness",
  "Subscriptions",
  "Internet",
  "Phone",
  "Software",
  "Games"
]

if Category.count == 0
  categories.each do |cat|
    Category.create(name: cat)
  end
end