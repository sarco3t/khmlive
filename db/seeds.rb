unless User.find_by(email: 'admin@admin.com')
  user = User.create(role: :admin, email: 'admin@admin.com', password: '123123')
  user.confirm
end
def category_with_logo(obj, logo)
  image_path = Rails.root.join('db', 'images')
  c = Category.create(obj)
  c.logo.attach(io: File.open("#{image_path}/#{logo}.jpg"), filename: logo)
  c
end

categories = []


categories << [Category.create(title: 'Новини', slug: 'news'), 'fa-newspaper']
categories << [Category.create(title: 'Афіша', slug: 'posters'), 'fa-window-restore']
categories << [Category.create(title: 'Довідник', slug: 'companies'), 'fa-book']
categories << [Category.create(title: 'Оголошення', slug: 'ads'), 'fa-bullhorn']

categories << [category_with_logo({ title: 'Запитання/Допомога' }, 'help'), 'fa-question-circle']
categories << [category_with_logo({ title: 'Історії Хмельничан' }, 'history'), 'fa-file-alt']
categories << [category_with_logo({ title: 'Шукаю тебе' }, 'search_you'), 'fa-heart']
categories << [category_with_logo({ title: 'Допомога тваринам' }, 'paw'), 'fa-paw']
categories << [category_with_logo({ title: 'Ревізор' }, 'auditor'), 'fa-hand-point-up']
categories << [Category.create(title: 'Народний топ'), 'fa-star']
categories << [category_with_logo({ title: 'Автомобілісти' }, 'motorist'), 'fa-car']
categories.each do |(c, i)|
  Menu.create(category_id: c.id, icon: i, enabled: true)
end

# Category.update_all(enabled: true)
